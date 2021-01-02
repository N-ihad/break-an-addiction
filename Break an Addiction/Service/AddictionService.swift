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
    
    var instructionTriggers: [Trigger] {
        return Array(addiction.instructions.keys)
    }
    
    var getOccurredTriggers: [Trigger] {
        return addiction.triggers.filter { trigger in
            trigger.count > 0
        }
    }
    
    // MARK: - Creation
    
//    func fetchAddiction() {
//        addiction = Addiction(triggers: triggers, relapses: relapses, reactions: reactions, instructions: nil)
//    }
    
    private init() {
        createAddiction()
    }
    
    func createAddiction() {
        addiction = Addiction(name: "", triggers: triggers, relapses: relapses, reactions: reactions, instructions: nil)
    }

    @discardableResult
    func addTrigger(name: String) throws -> Trigger {
        guard !hasTrigger(with: name) else {
            throw TriggerValidation.triggerWithSuchNameExists
        }
        
        guard !name.isEmpty else {
            throw TriggerValidation.triggerNameIsEmpty
        }
        
        let trigger = Trigger(name: name)
        addiction.triggers.insert(trigger, at: 0)
        
        return trigger
    }
    
    @discardableResult
    func addReaction(name: String) throws -> Reaction {
        guard !hasReaction(with: name) else {
            throw ReactionValidation.reactionWithSuchNameExists
        }
        
        guard !name.isEmpty else {
            throw ReactionValidation.reactionNameIsEmpty
        }
        
        let reaction = Reaction(name: name)
        addiction.reactions.insert(reaction, at: 0)
        
        return reaction
    }
    
    func addInstruction(triggerName: String, reactionName: String) throws {
        do {
            let trigger = try addTrigger(name: triggerName)
            let reaction = try addReaction(name: reactionName)
            trigger.reaction = reaction
            addiction.instructions[trigger] = reaction
        } catch let error {
            throw error
        }
    }
    
    func addRelapse(date: Date, instruction: [String : String]?, trigger: Trigger?) {
        addiction.relapses.append(Relapse(date: date, instruction: instruction, trigger: trigger))
    }
    
    // MARK: - Read
    
    func getAddictionName() -> String {
        return addiction.name
    }
    
    func getInstructions() -> [Trigger : Reaction] {
        return addiction.instructions
    }
    
    func getReaction(to trigger: Trigger) -> Reaction {
        return addiction.instructions[trigger]!
    }
    
    func getReactionsInString() -> [String] {
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
    
    func getLastRelapseDate() -> Date? {
        guard let relapse = addiction.relapses.last else { return nil }
        return relapse.date
    }
    
    func getTriggers() -> [Trigger] {
        return addiction.triggers
    }
    
    func getTrigger(at index: Int) throws -> Trigger {
        guard index >= 0 && index < addiction.triggers.count else {
            throw TriggerValidation.triggerAtSuchIndexDoesNotExist
        }
        
        return addiction.triggers[index]
    }
    
    func getTrigger(with name: String) -> Trigger {
        return addiction.triggers.first{$0.name == name}!
    }
    
    func getReactions() -> [Reaction] {
        return addiction.reactions
    }
    
    func getReaction(at index: Int) throws -> Reaction {
        guard index >= 0 && index < addiction.reactions.count else {
            throw ReactionValidation.reactionAtSuchIndexDoesNotExist
        }
        
        return addiction.reactions[index]
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
    
    func setAddictionName(name: String) {
        addiction.name = name
    }
    
    func incrementTriggerRelapseCount(name: String) {
        
    }
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


protocol LocalizedDescriptionError: Error {
    var localizedDescription: String { get }
}

extension AddictionService {
    enum TriggerValidation: LocalizedDescriptionError {
        
        case triggerWithSuchNameExists
        case triggerNameIsEmpty
        case triggerAtSuchIndexDoesNotExist
        
        var localizedDescription: String {
                switch self {
                case .triggerWithSuchNameExists:
                    return "Trigger with such name already exists"
                case .triggerNameIsEmpty:
                    return "Trigger name is empty. Can't add triggers with empty names"
                case .triggerAtSuchIndexDoesNotExist:
                    return "Trigger at such index does not exist"
                }
            }
    }
    
    enum ReactionValidation: LocalizedDescriptionError {
        
        case reactionWithSuchNameExists
        case reactionNameIsEmpty
        case reactionAtSuchIndexDoesNotExist
        
        var localizedDescription: String {
                switch self {
                case .reactionWithSuchNameExists:
                    return "Reaction with such name already exists"
                case .reactionNameIsEmpty:
                    return "Reaction name is empty. Can't add reactions with empty names"
                case .reactionAtSuchIndexDoesNotExist:
                    return "Reaction at such index does not exist"
                }
            }
    }
}
