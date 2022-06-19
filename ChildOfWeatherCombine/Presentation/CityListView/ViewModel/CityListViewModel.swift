//
//  CityListViewModel.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

protocol CityListViewModelInput {
    func fetchWeather(cityName: String)
}

protocol CityListViewModelOutput {
    var cities: [City] { get }
}

final class CityListViewModel: ObservableObject, CityListViewModelInput, CityListViewModelOutput {
    
    @Published var cities: [City] = []
    private let cityListUseCase: CityListUseCase
    private var bag = Set<AnyCancellable>()
    private let coordinator: Coordinator 
    
    init(
        cityListUseCase: CityListUseCase,
        coordinator: Coordinator
    ) {
        self.cityListUseCase = cityListUseCase
        self.coordinator = coordinator
    }
    
    private func fetchCityList() {
        self.cityListUseCase.fetchCities()
            .assign(to: \.cities, on: self)
            .store(in: &self.bag)
    }
    
    func fetchWeather(cityName: String) {
        
    }
}
