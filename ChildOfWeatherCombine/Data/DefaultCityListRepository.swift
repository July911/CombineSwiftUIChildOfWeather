//
//  DefaultCityListRepository.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

final actor DefaultCityListRepository: CityListRepository {
    
    var cityList: [City]?
    
    init() {
        self.cityList = self.fetchCity()
    }
    
    func fetchCityList() -> AnyPublisher<[City], Never> {
        guard let cityLists = self.cityList
        else {
            return Just([])
        }
        
        return Just(self.cityList)
    }
    
    private func fetchCity() -> [City] {
        
        return []
    }
}
