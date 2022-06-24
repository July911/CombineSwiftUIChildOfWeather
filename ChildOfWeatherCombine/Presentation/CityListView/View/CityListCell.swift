//
//  CityListCell.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/22.
//

import SwiftUI

struct CityListCell: View {
    
    let city: City
    
    var body: some View {
        HStack {
            VStack {
                Text("도시의 이름은?")
                Text(city.name.localized)
                    .fontWeight(.light)
                    .font(.callout)
            }
            
            Spacer()
            
        }
    }
}

struct CityListCell_Previews: PreviewProvider {
    static var previews: some View {
        CityListCell(city: City.EMPTY)
    }
}
