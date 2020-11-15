//
//  NetworkManager.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 15.11.2020.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    func getPositions(fromURL urlString: String, with completion: @escaping ([Job]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let positions = try JSONDecoder().decode([Job].self, from: data)
                completion(positions)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

