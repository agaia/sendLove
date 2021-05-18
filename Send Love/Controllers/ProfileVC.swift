//
//  ProfileVC.swift
//  Send Love
//
//  Created by Antoine Gaia on 16/01/2020.
//  Copyright © 2020 Antoine Gaia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var userPin: UILabel!
    @IBOutlet weak var partnerPin: UILabel!
    @IBOutlet weak var partnerIdTF: UITextField!
    
    var currentUser = Auth.auth().currentUser
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ref.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.userPin.text = "YOUR PIN IS: \(value!["linkPin"]!)"
            
            let partnerPin = "\(value!["partnerPin"]!)"
            
            if partnerPin != "0" {
                self.partnerPin.text = "LINKED TO: \(partnerPin)"
            } else {
                self.partnerPin.text = "NOT LINKED YET"
            }
        })
    }
    
    @IBAction func popBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            
        } catch let err {
            print(err)
        }
    }
    
    @IBAction func linkAction(_ sender: Any) {
        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            guard self.partnerIdTF.text != nil else { return }
            
            for item in value!.allKeys {
                if (item as! String) == self.currentUser?.uid {
                    continue
                }
                
                self.ref.child("users").child(item as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    if ("\(value!["linkPin"]!)" == self.partnerIdTF.text) {
                        //self.ref.child("users").child(self.currentUser!.uid).setValue(["partnerId": self.partnerIdTF.text])
                        
                        self.ref.child("users").child(self.currentUser!.uid).updateChildValues(["partnerId": (item as! String), "partnerPin": self.partnerIdTF.text])
                        
                        print("\n\nPartner Added successfully\n\n")
                        return
                    }
                })
            }
            
            print("\n\nCan't add anyone with this pin\n\n")
            
        })
    }
}
