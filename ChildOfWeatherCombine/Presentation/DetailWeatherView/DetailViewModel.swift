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
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    struct Input {
        var onAppear: AnyPublisher<Void,Never>
        var didSelectCell: AnyPublisher<IndexPath, Never>
    }
    
    struct Output {
        var weather: AnyPublisher<TodayWeather, Never>
    }
    
    init(useCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = useCase
    }
}
