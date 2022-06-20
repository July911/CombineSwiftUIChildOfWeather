//
//  CityList.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/20.
//

import Foundation

struct CityList {
    
    var city: [City]?
    
    init() {
        self.city = self.fetchCity()
    }
    
    private func fetchCity() -> [City] {
        guard let path = Bundle.main.url(forResource: "city", withExtension: "list")
        else {
            return []
        }
        
        guard let data = try? Data(contentsOf: path)
        else {
            return []
        }
        
        guard let cities = try? JSONDecoder().decode([City].self, from: data)
        else {
            return []
        }
        
        return cities
    }
}
