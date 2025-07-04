// Server.swift

import Foundation

// MARK: - 모델 정의

struct ScrapResponse: Codable {
    let brandId: Int
    let scrapped: Bool
    let scrapCount: Int
}

struct BrandScrap: Codable, Identifiable {
    var id: Int { brandId }
    let brandId: Int
    let brandName: String
    let brandLogoUrl: String
    let brandGenre: Int
}

// MARK: - 서버 통신 유틸리티

enum ServerFunc {
    static let baseURL = "https://pardaws.store/api"
    
    /// POST: 브랜드 스크랩 추가
    static func postScrap(brandId: Int) async throws -> ScrapResponse {
        guard let url = URL(string: "\(baseURL)/user/\(brandId)/scraps") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // 필요시 인증 헤더 추가
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(ScrapResponse.self, from: data)
    }
    
    /// GET: 유저의 스크랩 목록 조회
    static func getScraps(userId: Int) async throws -> [BrandScrap] {
        guard let url = URL(string: "\(baseURL)/user/\(userId)/scraps") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // 필요시 인증 헤더 추가
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([BrandScrap].self, from: data)
    }
    
    /// DELETE: 유저의 스크랩 삭제
    static func deleteScrap(userId: Int, brandId: Int) async throws {
        guard let url = URL(string: "\(baseURL)/user/\(userId)/scraps/\(brandId)") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // 필요시 인증 헤더 추가
        
        // Swagger 예시처럼 body에 [0]을 보냄
        let body = [0]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}


// MARK: - 사용 예시
/*
 import SwiftUI

 struct ContentView: View {
     @State private var userId: String = ""
     @State private var brandId: String = ""
     @State private var scraps: [BrandScrap] = []
     @State private var scrapResponse: ScrapResponse?
     @State private var errorMessage: String?
     @State private var isDeleteSuccess = false

     var body: some View {
         VStack(spacing: 16) {
             TextField("User ID", text: $userId)
                 .keyboardType(.numberPad)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
             TextField("Brand ID", text: $brandId)
                 .keyboardType(.numberPad)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
             
             HStack {
                 Button("POST 스크랩") {
                     Task {
                         await postScrap()
                     }
                 }
                 Button("GET 스크랩 목록") {
                     Task {
                         await getScraps()
                     }
                 }
                 Button("DELETE 스크랩") {
                     Task {
                         await deleteScrap()
                     }
                 }
             }
             
             if let scrapResponse = scrapResponse {
                 VStack(alignment: .leading) {
                     Text("Brand ID: \(scrapResponse.brandId)")
                     Text("Scrapped: \(scrapResponse.scrapped.description)")
                     Text("Scrap Count: \(scrapResponse.scrapCount)")
                 }
             }
             
             if !scraps.isEmpty {
                 List(scraps) { scrap in
                     VStack(alignment: .leading) {
                         Text(scrap.brandName)
                         Text("장르: \(scrap.brandGenre)")
                         Text(scrap.brandLogoUrl)
                             .font(.caption)
                             .foregroundColor(.gray)
                     }
                 }
                 .frame(height: 200)
             }
             
             if isDeleteSuccess {
                 Text("삭제 성공!").foregroundColor(.green)
             }
             if let errorMessage = errorMessage {
                 Text("에러: \(errorMessage)").foregroundColor(.red)
             }
         }
         .padding()
     }
     
     func postScrap() async {
         guard let brandIdInt = Int(brandId) else {
             errorMessage = "유효한 Brand ID를 입력하세요."
             return
         }
         do {
             let response = try await Server.postScrap(brandId: brandIdInt)
             scrapResponse = response
             errorMessage = nil
         } catch {
             errorMessage = error.localizedDescription
             scrapResponse = nil
         }
     }
     
     func getScraps() async {
         guard let userIdInt = Int(userId) else {
             errorMessage = "유효한 User ID를 입력하세요."
             return
         }
         do {
             let result = try await Server.getScraps(userId: userIdInt)
             scraps = result
             errorMessage = nil
         } catch {
             errorMessage = error.localizedDescription
             scraps = []
         }
     }
     
     func deleteScrap() async {
         guard let userIdInt = Int(userId), let brandIdInt = Int(brandId) else {
             errorMessage = "유효한 ID를 입력하세요."
             isDeleteSuccess = false
             return
         }
         do {
             try await Server.deleteScrap(userId: userIdInt, brandId: brandIdInt)
             isDeleteSuccess = true
             errorMessage = nil
         } catch {
             errorMessage = error.localizedDescription
             isDeleteSuccess = false
         }
     }
 }

 */


