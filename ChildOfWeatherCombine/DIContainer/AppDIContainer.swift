//
//  AppDIContainer.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/22.
//

import Foundation

final class AppDIContainer {
    
    static let shared = AppDIContainer()
    private let urlSessionService = URLSessionService()
    
    private init () { }
    
    func cityListDependencies() -> CityListViewModel {
        let dataStorage = DefaultCityListRepository()
        let useCase = CityListUseCase(repository: dataStorage)
        let viewModel = CityListViewModel(cityListUseCase: useCase)
        
        return viewModel
    }
    
    func detailWeatherDependencies(city: City) -> DetailViewModel {
        let dataStorage = DefaultWeatherRepository(service: self.urlSessionService)
        let useCase = FetchWeatherUseCase(repository: dataStorage)
        let viewModel = DetailViewModel(cityName: city.name, useCase: useCase)
        
        return viewModel
    }
}
