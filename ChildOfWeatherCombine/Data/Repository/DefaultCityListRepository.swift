//
//  DefaultCityListRepository.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

final actor DefaultCityListRepository: CityListRepository {
    
    private var cityList: [City]?
    //TODO: 계층 하나 더 만들어서 City를 래핑 가능 하게 만들어줌 
    init() {
        self.cityList = self.fetchCity()
    }
    
    nonisolated func fetchCityList() -> AnyPublisher<[City], Never> {
        return Just(cityList!).eraseToAnyPublisher()
    }
    
    private func fetchCity() -> [City] {
        guard let path = Bundle.main.url(forResource: "city", withExtension: "list")
        else {
            return []
        }
        
        guard let data = try? Data(contentsOf: path)
        else {
            return []
        }
        
        guard let cities = try? JSONDecoder().decode([City].self, from: data)
        else {
            return []
        }
        
        return cities
    }
}
