//
//  City.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation

struct City: Decodable {
    
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord: Coord
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
