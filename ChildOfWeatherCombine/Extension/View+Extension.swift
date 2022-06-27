//
//  View+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/27.
//

import Foundation
import SwiftUI

extension View {
    
    func minimumText() -> some View {
        modifier(FontSizingMinimum())
    }
}
