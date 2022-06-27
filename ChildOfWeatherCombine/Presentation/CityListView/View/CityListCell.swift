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
                Text(city.name.localized)
                    .fontWeight(.heavy)
                    .font(.callout)
                    .foregroundColor(Color.white)
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
