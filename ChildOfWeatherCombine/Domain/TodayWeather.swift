//
//  Weather.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation

struct TodayWeather {

    let maxTemperature: Double
    let minTemperature: Double
    let sunrise: Int
    let sunset: Int
    let description: String
}

extension TodayWeather {
    
    static var empty: TodayWeather {
        TodayWeather(maxTemperature: .zero, minTemperature: .zero, sunrise: .zero, sunset: .zero, description: "empty description")
    }
}
