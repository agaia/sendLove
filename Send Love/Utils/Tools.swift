//
//  Tools.swift
//  AdminHalfred
//
//  Created by Antoine Gaia on 01/10/2018.
//  Copyright © 2018 Halfred. All rights reserved.
//

import UIKit

extension UIViewController {
    func popAlert(msg: String, title: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.modalPresentationStyle = .popover
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

extension String {
    var isNumeric: Bool {
        let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-"]
        
        for item in self {
            if !nums.contains(String(item)) {
                return false
            }
        }
        return true
    }
}
