//
//  ViewModifier+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/24.
//

import Foundation
import SwiftUI

struct GradientColor: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [Color.red, Color.blue, Color.white],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .opacity(0.3)
            )
    }
}

