//
//  TableViewController.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class TableInfoVC: UIViewController {
    @IBOutlet var infoTableView: UITableView!
    @IBOutlet var genderSegmentControll: UISegmentedControl!
    @IBOutlet var ageFilter: UIBarButtonItem!

    var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.isHidden = true
        activity.hidesWhenStopped = true

        return activity
    }()

    var people = [Person]() {
        didSet {
            DispatchQueue.main.async {
                self.infoTableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center

        ModelManager.shared.addSubscriber(delegate: self)
        ModelManager.shared.getModel()

        infoTableView.delegate = self
        infoTableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailInfoVC,
            let cell = sender as? TableInfoCell else { return }
        destination.person = cell.person
    }

    @IBAction func searchBarButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Age Filter", message: nil, preferredStyle: .alert)
        let olderAction = UIAlertAction(title: "Older", style: .default) { _ in
            guard ModelManager.shared.model != nil else { return }
            self.activityIndicatorView.startAnimating()
            DispatchQueue(label: "filter").async {
                self.people = self.people.sorted { $0.dateOfBirtdh.getAgeWithBirthday() > $1.dateOfBirtdh.getAgeWithBirthday() }
            }
        }
        let youngerAction = UIAlertAction(title: "Younger", style: .default) { _ in
            guard ModelManager.shared.model != nil else { return }
            self.activityIndicatorView.startAnimating()
            DispatchQueue(label: "filter").async {
                self.people = self.people.sorted { $0.dateOfBirtdh.getAgeWithBirthday() < $1.dateOfBirtdh.getAgeWithBirthday() }
            }
        }

        alert.addAction(olderAction)
        alert.addAction(youngerAction)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func refreshBarButton(_ sender: UIBarButtonItem) {
        genderSegmentControll.selectedSegmentIndex = 0
        ModelManager.shared.getModel()
    }

    @IBAction func genderSegmentControll(_ sender: UISegmentedControl) {
        guard let model = ModelManager.shared.model else { return }
        switch sender.selectedSegmentIndex {
        case 0:
            people = model
        case 1:
            people = model.filter { $0.gender == .male }
        case 2:
            people = model.filter { $0.gender == .female }
        default: fatalError()
        }
        infoTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension TableInfoVC: ModelDelegate {
    func stateDidChange(state: DownloadState) {
        switch state {
        case .process:
            genderSegmentControll.isUserInteractionEnabled = false
            ageFilter.isEnabled = false
            activityIndicatorView.startAnimating()
        case .complete:
            genderSegmentControll.isUserInteractionEnabled = true
            ageFilter.isEnabled = true
            activityIndicatorView.stopAnimating()
        }
    }

    func modelDidChange(model: [Person]) {
        people = model
        infoTableView.reloadData()
    }
}
