//
//  Font.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

extension UIFont {
    static var textField: UIFont {
        .systemFont(ofSize: 16)
    }

    static var tagCell: UIFont {
        .boldSystemFont(ofSize: 16)
    }

    static var instructionCell: UIFont {
        .boldSystemFont(ofSize: 17)
    }

    static var dataFilterSelectedTab: UIFont {
        .boldSystemFont(ofSize: 16)
    }

    static var dataFilterNormalTab: UIFont {
        .systemFont(ofSize: 15)
    }

    static var abstainingCounter: UIFont {
        .boldSystemFont(ofSize: 34)
    }

    static var addictionName: UIFont {
        .boldSystemFont(ofSize: 24)
    }
}
