//
//  PositionsTableViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

import UIKit

class PositionsTableViewController: UITableViewController {
    
    var positions: [Job] = []
    
    var positionTitle: String!
    var locationTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPositions()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "position", for: indexPath)
        cell.textLabel?.text = positions[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = positions[indexPath.row].company
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let positionInfoVC = segue.destination as! PositionInfoViewController
        positionInfoVC.position = positions[indexPath.row]
    }

    
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
                    print(self.positions)
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }

        }.resume()
    }

}
