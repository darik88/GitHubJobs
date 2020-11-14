//
//  ViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var positionTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showResults", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsVC = segue.destination as! PositionsTableViewController
            resultsVC.positionTitle = positionTextField.text
            resultsVC.locationTitle = locationTextField.text
        }
    }
    
}

