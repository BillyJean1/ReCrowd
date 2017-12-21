//
//  RecommendationDetailViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 21-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class RecommendationDetailViewController: UIViewController {
    var recommendation: Recommendation?
    var recommendationWasStarted: Bool?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonUsability(enabled: recommendationWasStarted != true)
        
        if let rec = self.recommendation {
            self.nameLabel.text = rec.name
            self.pointsLabel.text = "\(rec.points)"
            self.descriptionLabel.text = rec.desc
        }
    }
    @IBAction func declineRecommendation(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAcceptRecommendation(_ sender: UIButton) {
        let alert = UIAlertController(title: "Aanbeveling accepteren", message: "Weet je zeker dat je deze suggestie wil accepteren?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { [weak weakSelf = self] action in
            weakSelf?.acceptRecommendation()
        }))
        alert.addAction(UIAlertAction(title: "Nee", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func acceptRecommendation() {
        if recommendation != nil {
            RecommendationService.shared.startRecommendation(recommendation: recommendation!)
            setButtonUsability(enabled: false)
        }
    }
    
    private func setButtonUsability(enabled: Bool) {
        self.acceptButton.isEnabled = enabled
        self.acceptButton.isHidden = !enabled
        
        self.declineButton.isEnabled = enabled
        self.declineButton.isHidden = !enabled
    }
}
