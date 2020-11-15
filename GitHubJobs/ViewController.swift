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
        performSegue(withIdentifier: "waitForSearch", sender: nil)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "waitForSearch" {
            let loaderVC = segue.destination as! WatForSearchViewController
            loaderVC.positionTitle = positionTextField.text
            loaderVC.locationTitle = locationTextField.text
        }
    }
}

