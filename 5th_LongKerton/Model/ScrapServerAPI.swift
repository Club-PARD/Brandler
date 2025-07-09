import Foundation

class ScrapeServerAPI: ObservableObject {
    
    func patchLike(email: String, brandId: Int, isScraped: Bool, completion: (() -> Void)? = nil) {
        guard let url = URL(string: "https://brandler.shop/scrap/\(email)/\(brandId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["isScraped": isScraped]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                let message = HTTPURLResponse.localizedString(forStatusCode: status)
                if 200 <= status && status < 300 {
                    print("✅ PATCH Success: \(status) \(message)")
                } else if 300 <= status && status < 400 {
                    print("➡️ PATCH Redirection: \(status) \(message)")
                } else if 400 <= status && status < 500 {
                    print("❌ PATCH Client Error: \(status) \(message)")
                } else if 500 <= status && status < 600 {
                    print("💥 PATCH Server Error: \(status) \(message)")
                } else {
                    print("❓ PATCH Unexpected status: \(status) \(message)")
                }
            }
            if let error = error {
                print("PATCH Network Error: \(error.localizedDescription)")
                return
            }
            completion?()
        }.resume()
    }

    
    func fetchIsScraped(email: String, brandId: Int, completion: @escaping (Bool?) -> Void) {
        guard let url = URL(string: "https://brandler.shop/scrap/\(email)/\(brandId)") else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("GET Scrap Network Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard
                let data = data,
                let httpResponse = response as? HTTPURLResponse
            else {
                completion(nil)
                return
            }
            let status = httpResponse.statusCode
            let message = HTTPURLResponse.localizedString(forStatusCode: status)
            if 200 <= status && status < 300 {
                print("✅ GET Success: \(status) \(message)")
            } else if 300 <= status && status < 400 {
                print("➡️ GET Redirection: \(status) \(message)")
            } else if 400 <= status && status < 500 {
                print("❌ GET Client Error: \(status) \(message)")
            } else if 500 <= status && status < 600 {
                print("💥 GET Server Error: \(status) \(message)")
            } else {
                print("❓ GET Unexpected status: \(status) \(message)")
            }

            if 200..<300 ~= status {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let isScraped = json["isScraped"] as? Bool {
                    completion(isScraped)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }

    func fetchScrapedBrands(email: String) async throws -> [BrandCard] {
                guard let url = URL(string: "https://brandler.shop/scrap/\(email)") else { return [] }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"

                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse {
                    let status = httpResponse.statusCode
                    let message = HTTPURLResponse.localizedString(forStatusCode: status)
                    if 200 <= status && status < 300 {
                        print("✅ GET Scraped Brands Success: \(status) \(message)")
                    } else if 300 <= status && status < 400 {
                        print("➡️ GET Redirection: \(status) \(message)")
                    } else if 400 <= status && status < 500 {
                        print("❌ GET Client Error: \(status) \(message)")
                    } else if 500 <= status && status < 600 {
                        print("💥 GET Server Error: \(status) \(message)")
                    } else {
                        print("❓ GET Unexpected status: \(status) \(message)")
                    }
                }
                let brands = try JSONDecoder().decode([BrandCard].self, from: data)
                return brands
            }
   
}
