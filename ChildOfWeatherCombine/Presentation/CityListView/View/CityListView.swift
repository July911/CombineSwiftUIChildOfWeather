//
//  ContentView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: CityListViewModel
    @State private var isSeached: Bool = false
    @State private var searchQuery: String = ""
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
                        DetailWeatherView(
                            viewModel: AppDIContainer.shared.detailWeatherDependencies(),
                            city: city
                        )
                    } label: {
                        Text("도시 리스트")
                            .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("도시")
            .shadow(color: Color.gray, radius: 10, x: 0.0, y: 10.0)
        }
        .searchable(text: $searchQuery) {
            ForEach(self.viewModel.searchedCities) { city in
                CityListCell(city: city)
            }
        }
        .onChange(of: searchQuery, perform: { querys in
            self.viewModel.searchedCities = self.viewModel.cities.filter { city in
                city.name.lowercased().contains(querys.lowercased())
            }
        })
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
