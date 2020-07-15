//
//  DetailInfoVC.swift
//  TestApp
//
//  Created by Li on 7/14/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class DetailInfoVC: UIViewController {
    var person: Person!
    var labels = [UILabel]()

    @IBOutlet var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureWithPerson()
    }

    func configureWithPerson() {
        addLabel(text: "ID: \(person.id)")
        let nameString = "Name: \(person.firstName) \(person.lastName)"
        addLabel(text: nameString)
        addLabel(text: "Email: \(person.email)")
        addLabel(text: "Gender: \(person.gender.rawValue)")
        addLabel(text: "Age: \(person.dateOfBirtdh.getAgeWithBirthday())")
    }

    func addLabel(text: String) {
        let label = UILabel()
        label.text = text
        stackView.addArrangedSubview(label)
        labels.append(label)
    }
}
