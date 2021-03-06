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
    
    let greenNote = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        greenNote.setFill()
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
