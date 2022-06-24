//
//  Task+Extension.swift
//  ChildOfWeatherCombine
//
//  Created by 조영민 on 2022/06/23.
//

import Foundation

extension Task: Cancelable {
    
}

protocol Cancelable {
    
    func cancel()
}

extension Task {
    
    func dispose(bag: CancelTaskBag) {
        bag.add(task: self)
    }
}
