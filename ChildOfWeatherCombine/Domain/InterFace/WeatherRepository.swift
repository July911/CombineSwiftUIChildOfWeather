//
//  WeatherRepository.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

protocol WeatherRepository {
    
    func fetchWeather(
        city: String
    ) -> AnyPublisher<TodayWeather, Error>
}
