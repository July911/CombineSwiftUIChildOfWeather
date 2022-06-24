//
//  ContentView.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: CityListViewModel
    @State private var searchQuery: String = ""
    private var bag = CancelTaskBag()
    
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationListView()
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery, perform: { querys in
                if !querys.isEmpty {
                    self.viewModel.searchedCities = self.viewModel.cities.filter { city in
                        city.name.contains(querys.lowercased())
                    }
                } else {
                    self.viewModel.searchedCities = self.viewModel.cities
                }
            })
            .onAppear {
                Task {
                    await self.viewModel.fetchCityList()
                }.dispose(bag: self.bag)
            }
            .onDisappear {
                self.bag.cancel()
            }
    }
    
    func NavigationListView() -> some View {
        return NavigationView {
            List {
                ForEach(self.viewModel.searchedCities) { city in
                    NavigationLink {
                        DetailWeatherView(
                            viewModel: AppDIContainer.shared.detailWeatherDependencies(),
                            city: city
                        )
                    } label: {
                        CityListCell(city: city)
                        
                    }
                    .listRowBackground(
                        LinearGradient(
                            colors: [Color.blue, Color.red, Color.white],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .opacity(0.3)
                    )
                }
            }
            .navigationTitle("도시")
            .shadow(color: Color.gray, radius: 10, x: 0.0, y: 10.0)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppDIContainer.shared.cityListDependencies()
        CityListView(viewModel: viewModel)
    }
}

