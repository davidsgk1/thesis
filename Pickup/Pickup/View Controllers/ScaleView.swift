//
//  ScaleView.swift
//  Pickup
//
//  Created by Keegan Davidson on 4/10/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
@IBDesignable

class ScaleView: UIView {

    public var scale = [String]()
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
