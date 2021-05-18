//
//  ViewController.swift
//  Send Love
//
//  Created by Antoine Gaia on 10/12/19.
//  Copyright © 2019 Antoine Gaia. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func LogInAction(_ sender: Any) {
        
        guard let email = usernameTextField.text else {
            return
        }
        
        guard let pwd = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pwd) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if error == nil {
                strongSelf.performSegue(withIdentifier: "goToHome", sender: nil)
            } else {
                strongSelf.popAlert(msg: "Error on Login", title: "Error")
            }
        }

    }
    
    @IBAction func SignUpAction(_ sender: Any) {
        
    }
    
    @IBAction func ForgotPwdAction(_ sender: Any) {
    }
}

