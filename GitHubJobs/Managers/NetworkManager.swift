//
//  NetworkManager.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 15.11.2020.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    func getPositions(fromURL urlString: String, with completion: @escaping ([JobPosition]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let positions = try JSONDecoder().decode([JobPosition].self, from: data)
                completion(positions)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func getPositionsViaAlamofire(with url: String, with completion: @escaping ([JobPosition]) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let result):
                    completion(JobPosition.getPositions(from: result) ?? [])
                case .failure(let error):
                    print(error)
                }
            }
        
    }
}

