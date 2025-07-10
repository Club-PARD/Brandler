import Foundation

enum WidgetAPI {
    static func fetchBrandRecommendations(for email: String) async throws -> [BrandRecommendation] {
        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://brandler.shop/brands/sort/\(encodedEmail)") else {
            print("❌ URL 생성 실패: https://brandler.shop/brands/sort/\(email)")
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        let responseBody = String(data: data, encoding: .utf8) ?? "본문 없음"
        print("📦 서버 응답 본문: \(responseBody)")

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("❌ 서버 응답 오류, 상태 코드: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys

        do {
            let decoded = try decoder.decode([BrandRecommendation].self, from: data)
            print("✅ 서버 데이터 디코딩 성공, 브랜드 개수: \(decoded.count)")
            return decoded
        } catch {
            print("❌ 디코딩 에러: \(error)")
            throw error
        }
    }
}
