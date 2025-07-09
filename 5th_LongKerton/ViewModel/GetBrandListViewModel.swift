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
    
//    public func getSortedList(_ email: String ) async throws -> [BrandCard] {
//        let urlString = BaseURL.baseUrl.rawValue
//        guard let url = URL(string: "\(urlString)/sort/\(email)") else {
//            throw ErrorType.invalidURL
//        }
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let HTTPresponse = response as? HTTPURLResponse, (200...299).contains(HTTPresponse.statusCode) else {
//            throw ErrorType.invalidResponse
//        }
//        
//        do{
//            let data = try JSONDecoder().decode([BrandCard].self,from:data)
//            print("✅ connet server sorted")
//            return(data)
//        } catch {
//            throw ErrorType.networkError
//        }
//    }
    
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
}
