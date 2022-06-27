//
//  ViewModifier+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/24.
//

import Foundation
import SwiftUI

struct FontSizingMinimum: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color.white)
            .padding()
    }
}

