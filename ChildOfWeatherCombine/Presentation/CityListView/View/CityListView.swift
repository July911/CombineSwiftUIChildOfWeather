//
//  ContentView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: CityListViewModel
    
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.cities) { city in
                    CityListCell(city: city)
                    NavigationLink {
                        DetailWeatherView(viewModel: DetailViewModel(cityName: city.name, useCase: FetchWeatherUseCase(repository: DefaultWeatherRepository(service: URLSessionService()))))
                    } label: {
                        VStack(alignment: .leading) {
                            Text(city.name)
                                .font(.title)
                                .bold()
                                .fontWeight(.bold)
                        }
                    }
                
                }
            }
            .navigationTitle("전국의 날씨")
        }
        .onAppear {
            self.viewModel.fetchCityList()
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(viewModel: CityListViewModel(cityListUseCase: CityListUseCase(repository: DefaultCityListRepository())))
    }
}
