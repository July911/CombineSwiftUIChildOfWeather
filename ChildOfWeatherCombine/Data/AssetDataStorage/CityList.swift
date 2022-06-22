//
//  CityList.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/20.
//

import Foundation
import UIKit

struct CityList {
    
    var city: [City]?
    
    init() {
        self.city = self.fetchCity()
    }
    
    private func fetchCity() -> [City] {
        let assetData = NSDataAsset(name: "city.list")
        guard let cities = try? JSONDecoder().decode([City].self, from: assetData?.data ?? Data())
        else {
            return [] 
        }
        
        return cities
    }
}
