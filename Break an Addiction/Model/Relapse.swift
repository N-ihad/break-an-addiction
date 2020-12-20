//
//  Relapse.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation

class Relapse {
    var date: Date
    var instruction: [String : String]?
    weak var trigger: Trigger?
    
    init(date: Date) {
        self.date = date
    }
    
    init(date: Date, instruction: [String : String]?) {
        self.date = date
        self.instruction = instruction
    }
    
    init(date: Date, instruction: [String : String]?, trigger: Trigger?) {
        self.date = date
        self.instruction = instruction
        self.trigger = trigger
    }
}
