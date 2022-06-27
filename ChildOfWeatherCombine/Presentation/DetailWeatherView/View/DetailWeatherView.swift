//
//  DetailWeatherView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/16.
//

import SwiftUI

struct DetailWeatherView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    //TODO: APPDI에서 같은 ViewModel을 각 WeatherDetailView에 넣어주었음
    // 같은 ViewModel인스턴스를 사용함
    let city: City
    var bag = CancelTaskBag()
    
    var body: some View {
        ZStack(alignment: .center) {
            RectangleView()
                .frame(height: 800)
            VStack {
                Text("오늘의 날씨")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                Text("오늘의 일출은 오전 \(self.viewModel.weather.sunrise.toKoreanTime.description)입니다.")
                    .fontWeight(.bold)
                    .minimumText()
                Text("오늘의 일몰은 오후 \(self.viewModel.weather.sunset.toKoreanTime.description)입니다.")
                    .fontWeight(.bold)
                    .minimumText()
                Text("오늘의 최고온도는 \(self.viewModel.weather.maxTemperature.toCelsius.description)도입니다.")
                    .fontWeight(.bold)
                    .minimumText()
                Text("오늘의 최저온도는 \(self.viewModel.weather.minTemperature.toCelsius.description)도입니다.")
                    .fontWeight(.bold)
                    .minimumText()
            }
        }
        .cornerRadius(10.0)
        Spacer()
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
                    colors: [Color.black, Color.blue, Color.purple],
                    startPoint: .top, endPoint: .bottom)
            )
            .opacity(0.7)
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
