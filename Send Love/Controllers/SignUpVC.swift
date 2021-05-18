//
//  SignUpVC.swift
//  Send Love
//
//  Created by Antoine Gaia on 10/12/19.
//  Copyright © 2019 Antoine Gaia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var pwd1TF: UITextField!
    @IBOutlet weak var pwd2TF: UITextField!
    @IBOutlet weak var pseudoTF: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwd1TF.passwordRules = UITextInputPasswordRules(descriptor: "minlength: 8;")
        ref = Database.database().reference()
    }
    
    @IBAction func SignUpAction(_ sender: Any) {
        
        guard let email = usernameTF.text else { return }
        guard let pwd = pwd1TF.text else { return }
        guard let pwd2 = pwd2TF.text else { return }
        
        if pwd == pwd2 {
            
            Auth.auth().createUser(withEmail: email, password: pwd) { [weak self] (user, error) in
                guard let strongSelf = self else { return }
                
                if error == nil {
                    strongSelf.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["partnerId": 0])
                    strongSelf.dismiss(animated: true, completion: nil)
                } else {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        
                        switch errCode {
                        case .emailAlreadyInUse:
                            strongSelf.popAlert(msg: "Email address already used", title: "Error")
                        case .missingEmail:
                            strongSelf.popAlert(msg: "Missing email", title: "Error")
                        default:
                            print("Create User Error: \(String(describing: error))")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
