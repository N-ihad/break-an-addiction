//
//  UIButton.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

extension UIButton {
    func setImage(size: CGFloat, imgName: String) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .large)
        let image = UIImage(systemName: imgName, withConfiguration: largeConfig)
        setImage(image, for: .normal)
    }
}
