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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView(viewModel: DetailViewModel(useCase:FetchWeatherUseCase(repository: DefaultWeatherRepository(service: URLSessionService())))
        )
    }
}
