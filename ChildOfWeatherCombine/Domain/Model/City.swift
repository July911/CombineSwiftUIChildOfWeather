//
//  City.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation

struct City: Decodable {
    
    let id: Int
    var name: String
    let state: String?
    let country: String
    let coord: Coord
}

extension City: Identifiable {
   
}

extension City {
    static let EMPTY = City(
        id: .zero,
        name: "",
        state: "",
        country: "",
        coord: Coord(lat: 1, lon: 1)
    )
}

struct Coord: Codable {
    let lat, lon: Double
}

extension City {
    var koreanName: City {
        var city = self
        city.name = city.name.localized
        return city
    }
}
