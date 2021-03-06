//
//  PositionsListViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 16.11.2020.
//

import UIKit

class PositionsListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loaderActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var morePositionsButton: UIButton!
    
    var positions: [JobPosition] = []
    var page: Int = 1
    var positionTitle: String!
    var locationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionTitle = positionTitle.replacingOccurrences(of: " ", with: "+")
        locationTitle = locationTitle.replacingOccurrences(of: " ", with: "+")
        getPositionsRequestAlamofire()
    }
    
    @IBAction func morePositionsButtonPressed() {
        page += 1
        getPositionsRequestAlamofire()
    }
    
    
    // MARK: - GET REQUESTS
    
    // Alamofire get request
    private func getPositionsRequestAlamofire() {
        morePositionsButton.isHidden = true
        loaderActivityIndicator.startAnimating()
        loaderActivityIndicator.hidesWhenStopped = true
        
        let url = "https://jobs.github.com/positions.json?description=\(positionTitle ?? "")&location=\(locationTitle ?? "")&page=\(page)"

        NetworkManager.shared.getPositionsViaAlamofire(with: url) { (positionsPerRequest) in
            DispatchQueue.main.async {
                guard positionsPerRequest.count > 0 else {
                    self.loaderActivityIndicator.stopAnimating()
                    self.noResultsFoundAlert()
                    return
                }
                
                self.positions += positionsPerRequest
                self.tableView.reloadData()
                self.loaderActivityIndicator.stopAnimating()
                // 50 positions per request by default
                self.morePositionsButton.isHidden = positionsPerRequest.count < 50
            }
        }
    }
    
    // URLSession get request
    private func getPositionsRequestURLSession() {
        morePositionsButton.isHidden = true
        loaderActivityIndicator.startAnimating()
        loaderActivityIndicator.hidesWhenStopped = true
        
        let url = "https://jobs.github.com/positions.json?description=\(positionTitle ?? "")&location=\(locationTitle ?? "")&page=\(page)"

        NetworkManager.shared.getPositions(fromURL: url) {(positionsPerRequest) in
            DispatchQueue.main.async {
                guard positionsPerRequest.count > 0 else {
                    self.loaderActivityIndicator.stopAnimating()
                    self.noResultsFoundAlert()
                    return
                }
                
                self.positions += positionsPerRequest
                self.tableView.reloadData()
                self.loaderActivityIndicator.stopAnimating()
                // 50 positions per request by default
                self.morePositionsButton.isHidden = positionsPerRequest.count < 50
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let positionInfoVC = segue.destination as! PositionInfoViewController
            positionInfoVC.position = positions[indexPath.row]
        }
    }

    
    // MARK: - 0 results alert
    private func noResultsFoundAlert() {
        let alert = UIAlertController(title: "No Results Found",
                                      message: "Sorry, No Positions Match You Found",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PositionsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "position", for: indexPath)
        cell.textLabel?.text = positions[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = positions[indexPath.row].company
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
