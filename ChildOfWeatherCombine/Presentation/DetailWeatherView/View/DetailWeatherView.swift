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
                .background(
                    LinearGradient(
                        colors: [Color.gray, Color.white],
                        startPoint: .leading, endPoint: .trailing)
                )
                .opacity(0.3)
                .shadow(color: Color.gray, radius: 10, x: 0, y: 10.0)
                .cornerRadius(10)
            
            HStack {
                VStack {
                    Text("오늘의 일출은?\n오전 \(self.viewModel.weather.sunrise.toKoreanTime.description)시")
                    Text("오늘의 일몰은?\n오후 \(self.viewModel.weather.sunset.toKoreanTime.description)시")
                }
                
                VStack {
                    Text("오늘의 최고온도는?\n\(self.viewModel.weather.maxTemperature.toCelsius.description)도")
                    Text("오늘의 최저온도는?\n\(self.viewModel.weather.minTemperature.toCelsius.description)도")
                }
            }
            .font(.callout)
        }
        .frame(width: 300, height: 200, alignment: .center)
        .onAppear {
            Task {
                await self.viewModel.fetchWeather(city: city)
            }
        }
    }
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppDIContainer.shared.detailWeatherDependencies()
        DetailWeatherView(viewModel: viewModel, city: City.EMPTY)
    }
}
