//
//  Int+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/19.
//

import Foundation

extension Int {
    
    var toKoreanTime: String {
        let time = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = Formatter.shared.dateformatter
        formatter.dateFormat = "HH: mm"
        
        return formatter.string(from: time)
    }
}
