//
//  CollectionViewSupport.swift
//  TestApp
//
//  Created by Li on 7/14/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

extension CollectionInfoVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}

extension CollectionInfoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionInfoCell.identifier, for: indexPath) as? CollectionInfoCell else { return UICollectionViewCell() }
        let person = people[indexPath.row]

        cell.configureWithPerson(person)
        return cell
    }
}

extension CollectionInfoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let widthPerItem = collectionView.bounds.width - paddingSpace
        return CGSize(width: widthPerItem, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
