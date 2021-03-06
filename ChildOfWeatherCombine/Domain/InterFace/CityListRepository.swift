//
//  File.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

protocol CityListRepository {
    
    func fetchCityList() async -> AnyPublisher<[City], Never>
}
