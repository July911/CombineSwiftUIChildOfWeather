//
//  DetailWeatherView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/16.
//

import SwiftUI

struct DetailWeatherView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    let city: City
    
    var body: some View {
        VStack {
            Text("도시의 이름은?\(city.name)")
            Text(self.viewModel.weather.sunrise.toKoreanTime.description)
                .padding()
            Text(self.viewModel.weather.maxTemperature.toCelsius.description)
                .font(.title)
            Text(self.viewModel.weather.minTemperature.toCelsius.description)
            Text(self.viewModel.weather.sunset.toKoreanTime.description)
        }
        .frame(width: 100, height: 500, alignment: .center)
        .onAppear {
            Task {
                await self.viewModel.fetchWeather(city: city)
            }
            print("도시의 이름은? \(city.name)")
        }
}
}
//
//struct DetailWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = AppDIContainer.shared.detailWeatherDependencies()
//        DetailWeatherView(viewModel: viewModel)
//    }
//}
