//
//  UICollectionView+CellSize.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func cellSize(for text: String) -> CGSize {
        var itemSize = text.size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        if itemSize.width > frame.width - 20 {
            itemSize.width = frame.width - 20
        }
        return CGSize(width: itemSize.width + 18, height: itemSize.height + 6)
    }
}
