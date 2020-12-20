//
//  Trigger.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation

class Trigger: TagViewProtocol {

    var name: String
    weak var reaction: Reaction?
    var relapses: [Relapse]
    
    init(name: String) {
        self.name = name
        reaction = nil
        relapses = []
    }
    
    init(name: String, reaction: Reaction) {
        self.name = name
        self.reaction = reaction
        relapses = []
    }
    
    init(name: String, reaction: Reaction, relapse: Relapse) {
        self.name = name
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
