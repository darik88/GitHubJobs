//
//  StartViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var positionTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchButtonPressed() {
        performSegue(withIdentifier: "loader", sender: nil)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        positionTextField.text = nil
        locationTextField.text = nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as! UINavigationController
        let positionsVC = navigationVC.topViewController as! PositionsListViewController
        positionsVC.positionTitle = positionTextField.text
        positionsVC.locationTitle = locationTextField.text
    }
}

extension StartViewController: UITextFieldDelegate {
    
    // Метод для скрытия клавиатуры тапом по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // Перевод курсора в следующее поле
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case positionTextField:
            locationTextField.becomeFirstResponder()
        case locationTextField:
            searchButtonPressed()
        default:
            break
        }
        return true
    }
}
