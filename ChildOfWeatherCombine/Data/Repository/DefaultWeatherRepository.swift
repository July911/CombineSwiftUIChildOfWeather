//
//  DefaultWeatherRepository.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

final class DefaultWeatherRepository: WeatherRepository {
 
    let service: URLSessionServiceProtocol
    
    init(service: URLSessionServiceProtocol) {
        self.service = service
    }
    
    func fetchWeather(city: String) -> AnyPublisher<TodayWeather, Error> {
        let param = CityWeatherRequestParams(city: city)
        let request = CityWeatherRequest(method: .GET, params: param)
        return self.service.requestCombine(request: request).tryMap {
            $0.toDomain()
        }.eraseToAnyPublisher()
    }
}
