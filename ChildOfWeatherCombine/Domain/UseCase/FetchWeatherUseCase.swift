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
    
    func fetchWether(city: String) async -> AnyPublisher<TodayWeather, Never> {
        await self.repository.fetchWeather(city: city)
    }
}
