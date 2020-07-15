//
//  NetworkManager.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    lazy var session: URLSession = {
        URLSession.shared
    }()

    var dataTask: URLSessionDataTask?

    func modelDataWith(urlString: String, complitionHandler: @escaping ([Person]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        dataTask?.cancel()
        dataTask = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Network Error: \(error!.localizedDescription)")
                return
            }

            let succesRange = Range(uncheckedBounds: (lower: 200, upper: 300))
            guard let httpResponse = response as? HTTPURLResponse,
                succesRange.contains(httpResponse.statusCode) else {
                print("Network Status Code Error: \(String(describing: response))")
                return
            }

            guard let strongData = data else {
                print("Network Error: nil Data")
                return
            }

            do {
                let model = try JSONDecoder().decode([Person].self, from: strongData)
                complitionHandler(model)
            } catch let error {
                print("Network Decode Error: \(error.localizedDescription)")
            }
        }
        dataTask?.resume()
    }
}
