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
                    .background(Color.white)
                Text(city.name)
            }
            
            Spacer()
            
            Text("알아보러 가보기")
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .font(.body)
            
            Circle()
                .trim()
                .shadow(color: .gray, radius: 10, x: 0, y: 10.0)
                .frame(width: 30, height: .infinity, alignment: .topTrailing)
        }
        .background(Color.blue.opacity(0.5))
    }
}

struct CityListCell_Previews: PreviewProvider {
    static var previews: some View {
        CityListCell(city: City.EMPTY)
    }
}