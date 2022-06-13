//
//  Publisher+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<T>() -> AnyPublisher<T, Error> where T: Decodable {
       return requestData()
           .decode(type: T.self, decoder: JSONDecoder())
           .receive(on: DispatchQueue.main)
           .eraseToAnyPublisher()
   }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData() -> AnyPublisher<Data, Error> {
        return tryMap {
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APICallError.invalidResponse
            }
            return $0.0
        }
        .eraseToAnyPublisher()
    }
}
