//
//  DataFilterView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

protocol DataFilterViewDelegate: AnyObject {
    func dataFilterView(_ view: DataFilterView, didSelect indexPath: IndexPath)
}

final class DataFilterView: UIView {

    private let reuseIdentifier = "DataCell"

    weak var delegate: DataFilterViewDelegate?

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DataFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func layout() {
        addSubview(collectionView)
        collectionView.pinTo(self)
    }
}

// MARK: - UICollectionViewDataSource {
extension DataFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DataFilterCell

        if indexPath.row == 0 {
            cell.setText("Relapses")
        } else {
            cell.setText("Triggers")
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DataFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.dataFilterView(self, didSelect: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DataFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


