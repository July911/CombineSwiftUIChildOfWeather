//
//  FetchWeatherUseCase.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

final class FetchWeatherUseCase {
    
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func fetchWether(city: String) -> AnyPublisher<TodayWeather, Error> {
        self.repository.fetchWeather(city: city)
    }
}
