//
//  AddictionService.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation


class AddictionService {
    
    static let shared = AddictionService()
    private var addiction: Addiction!
    
    // MARK: - Creation
    
//    func fetchAddiction() {
//        addiction = Addiction(triggers: triggers, relapses: relapses, reactions: reactions, instructions: nil)
//    }
    
    private init() {
        createAddiction(name: "")
    }
    
    func createAddiction(name: String) {
        addiction = Addiction(name: name, triggers: triggers, relapses: relapses, reactions: reactions, instructions: nil)
    }
    
    func fillUpModelWithSampleData() {
        
    }
    
    func addTrigger(name: String) throws {
        guard !hasTrigger(with: name) else {
            throw TriggerValidation.triggerWithSuchNameExists
        }
        
        guard !name.isEmpty else {
            throw TriggerValidation.triggerNameIsEmpty
        }
        
        let trigger = Trigger(name: name)
        addiction.triggers.insert(trigger, at: 0)
    }
    
    func addReaction(name: String) throws {
        guard !hasReaction(with: name) else {
            throw ReactionValidation.reactionWithSuchNameExists
        }
        
        guard !name.isEmpty else {
            throw ReactionValidation.reactionNameIsEmpty
        }
        
        addiction.reactions.insert(Reaction(name: name), at: 0)
    }
    
    func addInstruction(trigger: Trigger, reaction: Reaction) {
        trigger.reaction = reaction
        addiction.instructions[trigger] = reaction
    }
    
    func addRelapse(date: Date, instruction: [String : String]?, trigger: Trigger?) {
        addiction.relapses.append(Relapse(date: date, instruction: instruction, trigger: trigger))
    }
    
    // MARK: - Read
    
    func getTriggerReactionsInString() -> [String] {
        var stringReactions = [String]()
        addiction.reactions.forEach {
            stringReactions.append($0.name)
        }
        return stringReactions
    }
    
    func getTriggersInString() -> [String] {
        var stringTriggers = [String]()
        addiction.triggers.forEach {
            stringTriggers.append($0.name)
        }
        return stringTriggers
    }
    
    func getRelapses() -> [Relapse] {
        return addiction.relapses
    }
    
    func getTriggers() -> [Trigger] {
        return addiction.triggers
    }
    
    func getReactions() -> [Reaction] {
        return addiction.reactions
    }
    
    private func hasTrigger(with name: String) -> Bool {
        for trigger in addiction.triggers {
            if trigger.name == name {
                return true
            }
        }
        return false
    }
    
    private func hasReaction(with name: String) -> Bool {
        for reaction in addiction.reactions {
            if reaction.name == name {
                return true
            }
        }
        return false
    }
    
    func getCurrentAbstainingDate() -> Date? {
        return addiction.relapses.last?.date
    }
    
    // MARK: - Update
    
}



fileprivate let triggers = [Trigger(name: "saw alcohol in the store"),
                            Trigger(name: "argument with wife"),
                            Trigger(name: "saw whiskey on the table"),
                            Trigger(name: "staying bored at home"),
                            Trigger(name: "boss gives more work"),
                            Trigger(name: "seeing someone drinking in a movie")]

fileprivate let reactions = [Reaction(name: "don't go to the alcohol section"),
                             Reaction(name: "go out with friends"),
                             Reaction(name: "stop putting whiskey on table"),
                             Reaction(name: "go out"),
                             Reaction(name: "try timemanagement"),
                             Reaction(name: "don't watch movies first days")]

fileprivate let relapses = [Relapse]()
//fileprivate let relapses = [Relapse(relapseDate: Date.yesterday)]

extension AddictionService {
    enum TriggerValidation: Error, CustomStringConvertible {
        
        case triggerWithSuchNameExists
        case triggerNameIsEmpty
        
        var description: String {
                switch self {
                case .triggerWithSuchNameExists:
                    return "Trigger with such name already exists"
                case .triggerNameIsEmpty:
                    return "Trigger name is empty. Can't add triggers with empty names"
                }
            }
    }
    
    enum ReactionValidation: Error, CustomStringConvertible {
        case reactionWithSuchNameExists
        case reactionNameIsEmpty
        
        var description: String {
                switch self {
                case .reactionWithSuchNameExists:
                    return "Reaction with such name already exists"
                case .reactionNameIsEmpty:
                    return "Reaction name is empty. Can't add reactions with empty names"
                }
            }
    }
}
