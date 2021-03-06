//
//  WeatherInformation.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import Foundation

struct WeatherInformation: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    
    let temp: Double
    let maxTemperature: Double
    let minTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
    }
}

struct Weather: Codable {
    
    let description: String
    let main: String
}

struct Sys: Codable {
    
    let sunrise: Int
    let sunset: Int
}

extension WeatherInformation {
    
    func toDomain() -> TodayWeather {
        let maxTemperature = self.main.maxTemperature
        let minTeperature = self.main.minTemperature
        let sunSet = self.sys.sunset
        let sunRise = self.sys.sunrise
        let description = self.weather.first?.main
        
        return .init(
            maxTemperature: maxTemperature,
            minTemperature: minTeperature,
            sunrise: sunRise,
            sunset: sunSet,
            description: description!
        )
    }
}
