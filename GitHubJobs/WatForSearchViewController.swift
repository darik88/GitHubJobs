//
//  WatForSearchViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 15.11.2020.
//

import UIKit

class WatForSearchViewController: UIViewController {

    @IBOutlet var loaderActivityIndicator: UIActivityIndicatorView!
    
    var positions: [Job] = []
    
    var positionTitle: String!
    var locationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        loaderActivityIndicator.startAnimating()
        loaderActivityIndicator.hidesWhenStopped = true
        fetchPositions()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsVC = segue.destination as! PositionsTableViewController
            resultsVC.positions = positions
        }
    }
}


extension WatForSearchViewController {
    
    func fetchPositions() {
        let urlString = "https://jobs.github.com/positions.json?description=\(positionTitle ?? "")&location=\(locationTitle ?? "")"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                self.positions = try JSONDecoder().decode([Job].self, from: data)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showResults", sender: nil)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}


