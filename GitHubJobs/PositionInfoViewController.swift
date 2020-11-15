//
//  PositionInfoViewController.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

import UIKit

class PositionInfoViewController: UIViewController {
    
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var jobTypeLabel: UILabel!
    @IBOutlet var postedDateLabel: UILabel!
    @IBOutlet var jobDescriptionLabel: UILabel!
    var position: Job!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTitleLabel.text = position.title
        companyLabel.text = "Company: \(position.company ?? "0")"
        locationLabel.text = "Location: \(position.location ?? "0")"
        jobTypeLabel.text = "Job type: \(position.type ?? "0")"
        postedDateLabel.text = position.created_at
        jobDescriptionLabel.attributedText = position.description?.htmlAttributedString()
    }
}


extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

