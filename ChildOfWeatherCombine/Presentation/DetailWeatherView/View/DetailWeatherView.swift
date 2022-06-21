//
//  DetailWeatherView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/16.
//

import SwiftUI

struct DetailWeatherView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        NavigationView {
            Text(self.viewModel.weather.sunrise.toKoreanTime.description)
            Text(self.viewModel.weather.maxTemperature.toCelsius.description)
            Text(self.viewModel.weather.minTemperature.toCelsius.description)
            Text(self.viewModel.weather.sunset.toKoreanTime.description)
        }
        .navigationTitle("오늘의 날씨")
        .font(.title)
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            self.viewModel.fetchWeather()
        }
}
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView(viewModel: DetailViewModel(cityName: "오늘의 날씨", useCase:FetchWeatherUseCase(repository: DefaultWeatherRepository(service: URLSessionService())))
        )
    }
}
