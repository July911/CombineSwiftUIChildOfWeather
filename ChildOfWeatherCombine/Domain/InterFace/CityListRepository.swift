//
//  File.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

protocol CityListRepository {
    
    func fetchCityList() -> AnyPublisher<[City], Never>
}
