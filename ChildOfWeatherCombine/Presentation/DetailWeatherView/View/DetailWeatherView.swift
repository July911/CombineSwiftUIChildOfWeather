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
        ZStack {
            Spacer()
            
            Rectangle()
                .background(Color.gray)
                .opacity(0.3)
                .shadow(color: Color.gray, radius: 10, x: 0, y: 10.0)
                .cornerRadius(10)
            
            HStack {
                Text("오늘의 일출은? \(self.viewModel.weather.sunrise.toKoreanTime.description)")
                Text("오늘의 일몰은?\(self.viewModel.weather.sunset.toKoreanTime.description)")
                Text("오늘의 최고온도는?\(self.viewModel.weather.maxTemperature.toCelsius.description)")
                Text("오늘의 최저온도는?\(self.viewModel.weather.minTemperature.toCelsius.description)")
            }
            .font(.callout)
        }
        .onAppear {
            Task {
                await self.viewModel.fetchWeather(city: city)
            }
        }
    }
}
//Text(self.viewModel.weather.sunrise.toKoreanTime.description)
//Text(self.viewModel.weather.maxTemperature.toCelsius.description)
//Text(self.viewModel.weather.minTemperature.toCelsius.description)
//Text(self.viewModel.weather.sunset.toKoreanTime.description)
////
//struct DetailWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = AppDIContainer.shared.detailWeatherDependencies()
//        DetailWeatherView(viewModel: viewModel)
//    }
//}
