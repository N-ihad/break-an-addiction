//
//  TriggerTagView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

private let reuseIdentifier = "TagCell"

protocol TagViewProtocol {
    var name: String { get set }
}

class TagView: UIView {
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var data = [TagViewProtocol]()
    
    // MARK: - Lifecycle
    
    init(frame: CGRect, initializeWith data: [TagViewProtocol]) {
        super.init(frame: frame)
        
        self.heightAnchor.constraint(equalToConstant: 170).isActive = true
        self.data = data
        
        configureCollectionView()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.indicatorStyle = UIScrollView.IndicatorStyle.white
    }
    
    func configureSubviews() {
        addSubview(collectionView)
        collectionView.pinTo(self)
    }
}


extension TagView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TagCell
        
        cell.titleLabel.text = data[indexPath.row].name
        
        return cell
    }
}

extension TagView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = data[indexPath.row].name
        var itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ])
        if itemSize.width > self.frame.width - 20 {
            itemSize.width = self.frame.width - 20
        }
        return CGSize(width: itemSize.width + 18, height: itemSize.height + 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension TagView: UICollectionViewDelegate {
    
}


