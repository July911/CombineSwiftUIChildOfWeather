//
//  DetailViewModel.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/14.
//

import Foundation
import Combine

final class DetailViewModel {
    
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    init(useCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = useCase
    }
}
