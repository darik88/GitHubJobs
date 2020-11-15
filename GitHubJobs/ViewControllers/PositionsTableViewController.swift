//
//  PositionsTableViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

import UIKit

class PositionsTableViewController: UITableViewController {
    
    var positions: [Job] = []

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if positions.count == 0 {
            noResultsFoundAlert()
        }
        return positions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "position", for: indexPath)
        cell.textLabel?.text = positions[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = positions[indexPath.row].company
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let positionInfoVC = segue.destination as! PositionInfoViewController
        positionInfoVC.position = positions[indexPath.row]
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

