import Foundation

enum BaseURL : String {
    case baseUrl = "https://brandler.shop"
}

enum ErrorType : Error {
    case invalidURL
    case invalidResponse
    case networkError
}

struct UserServerAPI {
    static func uploadUserInfo(name: String, email: String, genre: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://brandler.shop/user/login") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "name": name,
            "email": email,
            "genre": genre
        ]
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                let message = HTTPURLResponse.localizedString(forStatusCode: status)
                if 200 <= status && status < 300 {
                    print("✅ POST Success: \(status) \(message)")
                } else if 300 <= status && status < 400 {
                    print("➡️ Redirection: \(status) \(message)")
                } else if 400 <= status && status < 500 {
                    print("❌ Client Error: \(status) \(message)")
                } else if 500 <= status && status < 600 {
                    print("💥 Server Error: \(status) \(message)")
                } else {
                    print("❓ Unexpected status: \(status) \(message)")
                }
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            // You can add additional logic here to check data if needed
            if let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    
    /// 이메일로 유저 정보 조회 (GET /user/{email})
    static func fetchUserInfo(email: String, completion: @escaping (UserSessionManager.UserData?) -> Void) {
        // 이메일을 URL-safe하게 인코딩
        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://brandler.shop/user/\(encodedEmail)") else {
            print("❌ Invalid URL for email: \(email)")
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                let message = HTTPURLResponse.localizedString(forStatusCode: status)
                if 200 <= status && status < 300 {
                    print("✅ GET Success: \(status) \(message)")
                } else if 300 <= status && status < 400 {
                    print("➡️ Redirection: \(status) \(message)")
                } else if 400 <= status && status < 500 {
                    print("❌ Client Error: \(status) \(message)")
                } else if 500 <= status && status < 600 {
                    print("💥 Server Error: \(status) \(message)")
                } else {
                    print("❓ Unexpected status: \(status) \(message)")
                }
            }
            if let error = error {
                print("Network User Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard
                let data = data,
                let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode
            else {
                completion(nil)
                return
            }
            // JSON 파싱
            if let user = try? JSONDecoder().decode(ServerUserResponse.self, from: data) {
                let userData = UserSessionManager.UserData(
                    email: user.email,
                    nickname: user.name,
                    fashionGenre: user.genre
                )
                completion(userData)
            } else {
                print("❌ JSON Decoding failed")
                completion(nil)
            }
        }.resume()
    }

    // 서버 응답 구조체
    private struct ServerUserResponse: Codable {
        let email: String
        let name: String
        let genre: String
    }
    
    
    
    static func patchUserInfo(email: String, nickname: String, genre: String, completion: @escaping (Bool) -> Void) {
            // 이메일을 URL-safe하게 인코딩
            guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let url = URL(string: "https://brandler.shop/user/\(encodedEmail)") else {
                print("❌ Invalid URL for email: \(email)")
                completion(false)
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: String] = [
                "name": nickname,
                "genre": genre
            ]
            request.httpBody = try? JSONEncoder().encode(body)

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
                    completion(false)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode {
                    completion(true)
                } else {
                    completion(false)
                }
            }.resume()
        }

    
    
    
    
}

