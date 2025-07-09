//
//  Top10ViewModel.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/9/25.
//

import SwiftUI

final class GetBrandListViewModel: ObservableObject {
    public func getTop10List() async throws -> [BrandCard] {
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/top10") else {
            throw ErrorType.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
            throw ErrorType.invalidResponse
        }
        
        do{
            let data = try JSONDecoder().decode([BrandCard].self,from:data)
            print("✅ connet server top10")
            return(data)
        } catch {
            throw ErrorType.networkError
        }
    }
    
    public func getSortedList(_ email: String ) async throws -> [GenreBrandCard] {
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/brands/sort/\(email)") else {
            print("❌ response server sorted \(urlString)/brands/sort/\(email)")
            throw ErrorType.invalidURL
        }
            
        let (data, response) = try await URLSession.shared.data(from: url)
        let responseBody = String(data: data, encoding: .utf8) ?? "본문 없음"
        
        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
            print("📦 서버 응답 본문: \(responseBody)")
            throw ErrorType.invalidResponse
        }
        
        do{
            let data = try JSONDecoder().decode([GenreBrandCard].self,from:data)
            print("✅ connet server sorted")
            return(data)
        } catch {
            throw ErrorType.networkError
        }
    }
    
    public func getRecentList(_ email: String) async throws -> [BrandCard] {
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/recent/\(email)") else {
            throw ErrorType.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
            print(response)
            throw ErrorType.invalidResponse
        }
        
        do{
            let data = try JSONDecoder().decode([BrandCard].self,from:data)
            print("✅ connet server recent")
            return(data)
        } catch {
            throw ErrorType.networkError
        }
    }
    
    public func getScrapList(_ email: String) async throws -> [BrandCard] {
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/scrap/\(email)") else {
            throw ErrorType.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
            print(response)
            throw ErrorType.invalidResponse
        }
        
        do{
            let data = try JSONDecoder().decode([BrandCard].self,from:data)
            print("✅ connet server recent")
            return(data)
        } catch {
            throw ErrorType.networkError
        }
    }
    
    public func getBrandInfo(_ email: String, _ brandId: Int) async throws -> BrandInfo {
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/brand/\(email)/\(brandId)") else {
            throw ErrorType.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
            print(response)
            throw ErrorType.invalidResponse
        }
        
        do{
            let data = try JSONDecoder().decode(BrandInfo.self,from:data)
            print("✅ connet server BrandInfo")
            return(data)
        } catch {
            throw ErrorType.networkError
        }
    }
    
}
