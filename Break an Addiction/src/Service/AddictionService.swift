//
//  AddictionService.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import Foundation

final class AddictionService {
    
    static let shared = AddictionService()

    private let addiction: Addiction!

    var addictionName: String {
        addiction.name
    }

    var instructions: [Trigger : Reaction] {
        addiction.instructions
    }

    var instructionTriggers: [Trigger] {
        addiction.instructions.keys.map { $0 }
    }

    var currentAbstainingDate: Date? {
        addiction.relapses.last?.date
    }

    var triggers: [Trigger] {
        addiction.triggers
    }

    var triggerNames: [String] {
        return addiction.triggers.map { $0.name }
    }

    var occurredTriggers: [Trigger] {
        addiction.triggers.filter { $0.count > 0 }
    }

    var reactions: [Reaction] {
        addiction.reactions
    }

    var reactionNames: [String] {
        addiction.reactions.map { $0.name }
    }

    var relapses: [Relapse] {
        addiction.relapses
    }

    var lastRelapseDate: Date? {
        guard let relapse = addiction.relapses.last else { return nil }
        return relapse.date
    }

    private init() {
        addiction = Addiction(
            name: "",
            triggers: AddictionService.triggers,
            relapses: AddictionService.relapses,
            reactions: AddictionService.reactions,
            instructions: nil
        )
    }

    // MARK: - POST
    @discardableResult
    func addTrigger(name: String) throws -> Trigger {
        guard !triggers.contains(where: { $0.name == name }) else {
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
        guard !reactions.contains(where: { $0.name == name }) else {
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
    
    // MARK: - GET
    func trigger(at index: Int) throws -> Trigger {
        guard index >= 0 && index < addiction.triggers.count else {
            throw TriggerValidation.triggerAtSuchIndexDoesNotExist
        }
        
        return addiction.triggers[index]
    }
    
    func trigger(with name: String) -> Trigger {
        return addiction.triggers.first{$0.name == name}!
    }
    
    func reaction(at index: Int) throws -> Reaction {
        guard index >= 0 && index < addiction.reactions.count else {
            throw ReactionValidation.reactionAtSuchIndexDoesNotExist
        }
        
        return addiction.reactions[index]
    }

    func reaction(for trigger: Trigger) -> Reaction {
        return addiction.instructions[trigger]!
    }

    // MARK: - PUT
    func setAddictionName(name: String) {
        addiction.name = name
    }
    
    func incrementTriggerRelapseCount(name: String) {
    }
}

// MARK: - Mock data
extension AddictionService {
    fileprivate static let triggers = [
        Trigger(name: "saw alcohol in the store"),
        Trigger(name: "argument with wife"),
        Trigger(name: "saw whiskey on the table"),
        Trigger(name: "staying bored at home"),
        Trigger(name: "boss gives more work"),
        Trigger(name: "seeing someone drinking in a movie")
    ]

    fileprivate static let reactions = [
        Reaction(name: "don't go to the alcohol section"),
        Reaction(name: "go out with friends"),
        Reaction(name: "stop putting whiskey on table"),
        Reaction(name: "go out"),
        Reaction(name: "try timemanagement"),
        Reaction(name: "don't watch movies first days")
    ]

    fileprivate static let relapses = [Relapse]()
}
