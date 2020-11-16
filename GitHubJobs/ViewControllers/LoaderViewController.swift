//
//  LoaderViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 15.11.2020.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet var loaderActivityIndicator: UIActivityIndicatorView!
    
    var positions: [Job] = []
    
    var positionTitle: String!
    var locationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionTitle = positionTitle.replacingOccurrences(of: " ", with: "+")
        locationTitle = locationTitle.replacingOccurrences(of: " ", with: "+")
        navigationItem.hidesBackButton = true
        loaderActivityIndicator.startAnimating()
        loaderActivityIndicator.hidesWhenStopped = true
        
        let url = "https://jobs.github.com/positions.json?description=\(positionTitle ?? "")&location=\(locationTitle ?? "")"
        
        NetworkManager.shared.getPositions(fromURL: url) {(positions) in
            DispatchQueue.main.async {
                self.positions = positions
                self.performSegue(withIdentifier: "showResults", sender: nil)
                self.loaderActivityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsVC = segue.destination as! PositionsTableViewController
            resultsVC.positions = positions
        }
    }
}
