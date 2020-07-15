//
//  CollectionInfoCell.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class CollectionInfoCell: UICollectionViewCell {
    static let identifier = "collectionInfoCell"

    @IBOutlet var stackView: UIStackView!

    var person: Person!
    var labels = [UILabel]()

    func configureWithPerson(_ person: Person) {
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 0.03 * self.frame.width

        self.person = person

        let nameString = "\(person.firstName) \(person.lastName)"
        addLabel(text: nameString)
        addLabel(text: person.gender.rawValue)
        addLabel(text: person.dateOfBirtdh.getAgeWithBirthday())
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        labels.forEach { label in
            let removeLabel = stackView.arrangedSubviews.first { $0 === label }
            removeLabel?.removeFromSuperview()
            labels.removeAll { $0 === label }
        }
    }

    func addLabel(text: String) {
        let label = UILabel()
        label.text = text
        stackView.addArrangedSubview(label)
        labels.append(label)
    }
}
