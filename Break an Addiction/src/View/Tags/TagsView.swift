//
//  TriggerTagView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class TagsView: UIView {

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        heightAnchor.constraint(equalToConstant: 170).isActive = true

        addSubview(collectionView)
        collectionView.pinTo(self)
    }
}
