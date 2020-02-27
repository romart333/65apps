//
//  ViewController.swift
//  Forth
//
//  Created by user167101 on 2/25/20.
//  Copyright © 2020 user167101. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var loginStateLabel: UILabel!
    
    @IBOutlet private weak var loginInputTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        loginStateLabel.isHidden = true
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        loginStateLabel.isHidden = false
        let login = loginInputTextField.text ?? ""
        if LoginChecker.shared.checkLogin(login: login) {
            loginStateLabel.textColor = UIColor.green
            loginStateLabel.text = "Valid login!!!"
        
        } else {
            loginStateLabel.textColor = UIColor.red
            loginStateLabel.text = "Incorrect login!"
        }
    }
    
}

