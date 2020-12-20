//
//  Addiction.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation

class Addiction {
    var name: String
    var triggers: [Trigger]
    var relapses: [Relapse]
    var reactions: [Reaction]
    var instructions: [Trigger : Reaction]
    
    init(name: String) {
        self.name = name
        self.triggers = []
        self.relapses = []
        self.reactions = []
        self.instructions = [:]
    }
    
    init(name: String, triggers: [Trigger]?, relapses: [Relapse]?, reactions: [Reaction]?, instructions: [Trigger : Reaction]?) {
        self.name = name
        self.triggers = []
        self.relapses = []
        self.reactions = []
        self.instructions = [:]
        
        if let triggers = triggers {
            self.triggers = triggers
        }
        
        if let relapses = relapses {
            self.relapses = relapses
        }
        
        if let reactions = reactions {
            self.reactions = reactions
        }
        
        if let instructions = instructions {
            self.instructions = instructions
        }
    }
    
}
