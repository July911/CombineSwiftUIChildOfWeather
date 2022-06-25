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
    
    func fetchWeather(city: String) async -> AnyPublisher<TodayWeather, Never> {
        let param = CityWeatherRequestParams(city: city)
        let request = CityWeatherRequest(method: .GET, params: param)
        guard let decoded = try? await self.service.request(requestType: request) else {
            return Just(TodayWeather.empty).eraseToAnyPublisher()
        }

        return Just(decoded.toDomain()).eraseToAnyPublisher()
    }
}
