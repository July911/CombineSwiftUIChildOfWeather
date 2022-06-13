//
//  APICaller+Combine.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

extension URLSessionServiceProtocol {
    
    func requestCombine<T: APIRequest>(request: T) -> AnyPublisher<T.ResponseType, Error> {
            return URLSession.shared.dataTaskPublisher(for: request.urlRequest!)
                .requestJSON()
    }
}



