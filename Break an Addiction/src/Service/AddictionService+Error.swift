//
//  AddictionService+Error.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation

protocol LocalizedDescriptionError: Error {
    var localizedDescription: String { get }
}

extension AddictionManager {
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
