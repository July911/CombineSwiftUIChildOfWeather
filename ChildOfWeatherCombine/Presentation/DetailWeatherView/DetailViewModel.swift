//
//  DetailViewModel.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var weather: TodayWeather = TodayWeather.empty
    let cityName: String
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private var cancalBag = Set<AnyCancellable>()
    struct Input {
        var onAppear: AnyPublisher<Void,Never>
        var didSelectCell: AnyPublisher<IndexPath, Never>
    }
    
    struct Output {
        var weather: AnyPublisher<TodayWeather, Never>
    }
    
    init(cityName: String, useCase: FetchWeatherUseCase) {
        self.cityName = cityName
        self.fetchWeatherUseCase = useCase
    }
    
    func fetchWeather() {
        self.fetchWeatherUseCase.fetchWether(city: self.cityName)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            }, receiveValue: { todayWeather in
                self.weather = todayWeather
            }
            ).store(in: &self.cancalBag)
    }
}
