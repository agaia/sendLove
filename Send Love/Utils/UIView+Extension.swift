//
//  UIView+Extension.swift
//  AdminHalfred
//
//  Created by Antoine Gaia on 02/10/2018.
//  Copyright © 2018 Halfred. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
    }
    
    func dropHalfredShadow() {
        let layer = UIView(frame: CGRect(x: 20, y: 256, width: 335, height: 110))
        layer.layer.cornerRadius = 5
        layer.backgroundColor = UIColor.white
        layer.layer.borderWidth = 1
        layer.layer.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        layer.layer.shadowOffset = CGSize(width: 0, height: 11)
        layer.layer.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        layer.layer.shadowOpacity = 1
        layer.layer.shadowRadius = 14
    }
}
