//
//  SplashScreenVC.swift
//  Send Love
//
//  Created by Antoine Gaia on 16/01/2020.
//  Copyright © 2020 Antoine Gaia. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        manageNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manageNavigation()
    }

    func manageNavigation() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToHome", sender: nil)
        } else {
            self.performSegue(withIdentifier: "goToLogin", sender: nil)
        }
    }
}
