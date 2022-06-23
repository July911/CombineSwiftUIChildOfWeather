//
//  CityListViewModel.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation
import Combine

protocol CityListViewModelInput {
    func fetchCityList() async
    func searchCityList(cityName: String) async
}

protocol CityListViewModelOutput {
    var cities: [City] { get }
}

final class CityListViewModel: ObservableObject, CityListViewModelInput, CityListViewModelOutput {
    
    @Published var cities: [City] = []
    @Published var searchedCities: [City] = []
    private let cityListUseCase: CityListUseCase
    private var bag = Set<AnyCancellable>()
    
    init(
        cityListUseCase: CityListUseCase
    ) {
        self.cityListUseCase = cityListUseCase
    }
    
    func fetchCityList() async {
        await self.cityListUseCase.fetchCities()
            .assign(to: \.cities, on: self)
            .store(in: &self.bag)
    }
    
    func searchCityList(cityName: String) async {
        await self.cityListUseCase.fetchCities()
            .map { cities in
                cities.filter { city in
                    city.name.first?.description == cityName
                }
            }.assign(to: \.searchedCities, on: self)
            .store(in: &self.bag)
    }
}
