//
//  CityListUseCase.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

final class CityListUseCase {
    
    var repository: CityListRepository
    
    init(repository: CityListRepository) {
        self.repository = repository
    }
    
    func fetchCities() async -> AnyPublisher<[City], Never> {
        await self.repository.fetchCityList()
    }
}
