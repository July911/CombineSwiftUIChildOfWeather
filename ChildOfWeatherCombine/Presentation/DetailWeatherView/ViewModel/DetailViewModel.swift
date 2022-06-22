//
//  DetailViewModel.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

protocol DetailViewModelInput {
    var weather: TodayWeather { get set }
}

protocol DetailViewModelOutput {
    func fetchWeather(city: City) async
}

final class DetailViewModel: ObservableObject, DetailViewModelInput, DetailViewModelOutput {
    
    @Published var weather: TodayWeather = TodayWeather.empty
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private var cancalBag = Set<AnyCancellable>()
    
    init(useCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = useCase
    }
    
    func fetchWeather(city: City) async {
        await self.fetchWeatherUseCase.fetchWether(city: city.name)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            }, receiveValue: { todayWeather in
                print(todayWeather.sunset)
                print(todayWeather.description)
                self.weather = todayWeather
            }
            ).store(in: &self.cancalBag)
    }
}
