//
//  ContentView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: CityListViewModel
    private var clickedCity: City = City.EMPTY
    
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.cities) { city in
                    CityListCell(city: city)
                    NavigationLink {
                        DetailWeatherView(viewModel: AppDIContainer.shared.detailWeatherDependencies(), city: city)
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
            .navigationTitle("도시리스트")
        }
        .onAppear {
            Task {
            await self.viewModel.fetchCityList()
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppDIContainer.shared.cityListDependencies()
        CityListView(viewModel: viewModel)
    }
}
