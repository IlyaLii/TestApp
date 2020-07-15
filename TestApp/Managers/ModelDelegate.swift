//
//  ModelDelegate.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

protocol ModelDelegate: class {
    func modelDidChange(model: [Person])
    func stateDidChange(state: DownloadState)
}
