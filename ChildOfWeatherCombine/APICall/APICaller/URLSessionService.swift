//
//  APICaller.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation

final class URLSessionService: URLSessionServiceProtocol {
    
    let session = URLSession.shared
    
    func request<T: APIRequest>(
        requestType: T
    ) async throws -> T.ResponseType
        {
        
        guard let request = requestType.urlRequest else {
            throw APICallError.dataNotfetched
        }
            
        guard let (data, response) = try? await session.data(for: request)
            else {
            throw APICallError.dataNotfetched
        }
            
        guard let decoded = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
            throw APICallError.failureDecoding
        }
            
        return decoded
    }
}

enum APICallError: Error {
    
    case invalidResponse
    case errorExist
    case failureDecoding
    case notProperStatusCode(code: Int)
    case dataNotfetched
}

