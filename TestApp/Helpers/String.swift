//
//  String.swift
//  TestApp
//
//  Created by Li on 7/15/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation

extension String {
    func getAgeWithBirthday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"

        guard let birthday = formatter.date(from: self) else { return "0" }
        let now = Date()

        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        return "\(ageComponents.year ?? 0)"
    }
}
