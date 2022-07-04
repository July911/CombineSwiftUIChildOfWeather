//
//  URLSessionService.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation

protocol URLSessionServiceProtocol {
    
    func request<T: APIRequest>(
        requestType: T
    ) async throws -> T.ResponseType
}
