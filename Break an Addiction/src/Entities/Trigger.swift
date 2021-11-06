//
//  Trigger.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation

final class Trigger {

    var name: String
    var relapses: [Relapse]
    var count: UInt

    weak var reaction: Reaction?

    init(name: String) {
        self.name = name
        reaction = nil
        relapses = []
        count = 0
    }
    
    init(name: String, count: UInt) {
        self.name = name
        self.count = count
        reaction = nil
        relapses = []
    }
    
    init(name: String, count: UInt, reaction: Reaction) {
        self.name = name
        self.count = count
        self.reaction = reaction
        relapses = []
    }
    
    init(name: String, count: UInt, reaction: Reaction, relapse: Relapse) {
        self.name = name
        self.count = count
        self.reaction = reaction
        self.relapses = [relapse]
    }
}

extension Trigger: Hashable {
    
    static func == (lhs: Trigger, rhs: Trigger) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
