import Foundation

struct SearchAPI {
    func searchBrand(keyword: String) async throws -> [SearchBrand] {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://brandler.shop/search/brand/\(encodedKeyword)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpRes = response as? HTTPURLResponse {
            print("📡 상태 코드: \(httpRes.statusCode)")
            print("📦 응답 데이터: \(String(data: data, encoding: .utf8) ?? "응답 없음")")
        }

        guard let httpRes = response as? HTTPURLResponse, 200..<300 ~= httpRes.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([SearchBrand].self, from: data)
    }

    func searchProduct(keyword: String) async throws -> [SearchProduct] {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://brandler.shop/search/product/\(encodedKeyword)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpRes = response as? HTTPURLResponse {
            print("📡 상태 코드: \(httpRes.statusCode)")
            print("📦 응답 데이터: \(String(data: data, encoding: .utf8) ?? "응답 없음")")
        }

        guard let httpRes = response as? HTTPURLResponse, 200..<300 ~= httpRes.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([SearchProduct].self, from: data)
    }
}
