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
        guard let url = URL(string: "https://brandler.shop/user") else {
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
            if let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
}

