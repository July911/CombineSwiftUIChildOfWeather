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
}

protocol CityListViewModelOutput {
    var cities: [City] { get }
}

final class CityListViewModel: ObservableObject, CityListViewModelInput, CityListViewModelOutput {
    
    @Published var cities: [City] = []
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
        print(cities)
    }
}
