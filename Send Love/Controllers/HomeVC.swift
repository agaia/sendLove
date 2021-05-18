//
//  HomeVC.swift
//  Send Love
//
//  Created by Antoine Gaia on 10/12/19.
//  Copyright © 2019 Antoine Gaia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeVC: UIViewController {
    
    @IBOutlet weak var sendLoveButton: UIButton!
    @IBOutlet weak var logMessageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentUser = Auth.auth().currentUser
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //checkIfLinked()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfLinked()
    }
    
    // MARK: -UI FUNCTIONS
    
    func checkIfLinked() {
        
        startAnim()
        sendLoveButton.isEnabled = false
        logMessageLabel.text = "Checking connection..."
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        self.ref.child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let partnerId = value?["partnerId"] as? String ?? "0"
            
            if partnerId == "0" {
                self.sendLoveButton.isEnabled = false
                self.logMessageLabel.text = "You are not linked to anyone... yet"
                self.stopAnim()
            } else {
                self.sendLoveButton.isEnabled = true
                self.logMessageLabel.text = "It's time to spread your love <3"
                self.stopAnim()
            }
        })
    }
    
    func startAnim() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func stopAnim() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    // MARK: -ACTIONS
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.navigationController?.popViewController(animated: true)
            
        } catch let err {
            print(err)
        }
    }
    
    @IBAction func sendLoveAction(_ sender: Any) {
        ///Todo: Send love to linked user
    }
}
