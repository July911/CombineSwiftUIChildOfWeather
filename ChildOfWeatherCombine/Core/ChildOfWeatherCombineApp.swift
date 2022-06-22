//
//  ChildOfWeatherCombineApp.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/12.
//

import SwiftUI

@main
struct ChildOfWeatherCombineApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AppDIContainer.shared.cityListDependencies()
            CityListView(viewModel: viewModel)
        }
    }
}
