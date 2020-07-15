//
//  ModelManager.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class ModelManager {
    static let shared = ModelManager()
    var subscribers = [ModelDelegate]()

    var modelUrlString = "https://my.api.mockaroo.com/persons.json?key=f43efc60"
    var model: [Person]? {
        didSet {
            DispatchQueue.main.async {
                self.modelDidChange()
            }
        }
    }

    var downloadState: DownloadState = .process {
        didSet {
            DispatchQueue.main.async {
                self.stateDidChange()
            }
        }
    }

    func addSubscriber(delegate: ModelDelegate) {
        subscribers.append(delegate)
        DispatchQueue.main.async {
            if let model = self.model {
                delegate.modelDidChange(model: model)
            } else {
                delegate.stateDidChange(state: self.downloadState)
            }
        }
    }

    func removeSubscriber(delegate: ModelDelegate) {
        subscribers.removeAll { $0 === delegate }
    }

    func modelDidChange() {
        guard let strongModel = model else { return }
        subscribers.forEach { sub in
            sub.modelDidChange(model: strongModel)
        }
    }

    func stateDidChange() {
        subscribers.forEach { sub in
            sub.stateDidChange(state: downloadState)
        }
    }

    func getModel() {
        downloadState = .process
        NetworkManager.shared.modelDataWith(urlString: modelUrlString) { persons in
            self.downloadState = .complete
            self.model = persons
        }
    }
}
