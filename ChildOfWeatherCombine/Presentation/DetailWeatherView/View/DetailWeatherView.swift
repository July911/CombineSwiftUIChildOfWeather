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
    var bag = CancelTaskBag()
    
    var body: some View {
        NavigationView {
            ZStack {
                RectangleView()
                HStack {
                    VStack {
                        Text("오늘의 일출은?\n오전 \(self.viewModel.weather.sunrise.toKoreanTime.description)시")
                            .fontWeight(.bold)
                            .font(.body)
                        Text("오늘의 일몰은?\n오후 \(self.viewModel.weather.sunset.toKoreanTime.description)시")
                            .fontWeight(.bold)
                            .font(.body)
                    }
                    
                    VStack {
                        Text("오늘의 최고온도는?\n\(self.viewModel.weather.maxTemperature.toCelsius.description)도")
                            .fontWeight(.bold)
                            .font(.body)
                        Text("오늘의 최저온도는?\n\(self.viewModel.weather.minTemperature.toCelsius.description)도")
                            .fontWeight(.bold)
                            .font(.body)
                    }
                }
            }
        }
        Spacer()
        .navigationTitle("오늘의 날씨")
        .frame(width: 300, height: 200, alignment: .center)
        .cornerRadius(10.0)
        .onAppear {
            Task {
                await self.viewModel.fetchWeather(city: self.city)
            }.dispose(bag: self.bag)
        }
        .onDisappear {
            self.bag.cancel()
        }
    }
    
    func RectangleView() -> some View {
        return  Rectangle()
            .background(
                LinearGradient(
                    colors: [Color.blue,Color.red,Color.white],
                    startPoint: .leading, endPoint: .trailing)
            )
            .opacity(0.3)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 10.0)
            .cornerRadius(10)
    }
}

//struct DetailWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = AppDIContainer.shared.detailWeatherDependencies()
//        DetailWeatherView(viewModel: viewModel, city: City.EMPTY)
//    }
//}
