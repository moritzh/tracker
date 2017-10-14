//
//  ErrorViewController.swift
//  Tracker
//
//  Created by Moritz on 15.10.17.
//  Copyright © 2017 Moritz Haarmann. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        descriptionLabel.text = "Tracker doesn't have access to your location\nPlease fix that in Settings and come back."
        
        descriptionLabel.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
