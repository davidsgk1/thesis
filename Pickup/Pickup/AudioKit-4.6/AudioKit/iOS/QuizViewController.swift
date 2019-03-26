//
//  QuizViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 3/25/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuizViewController: UIPageViewController {
    
    let ref = Database.database().reference(withPath: "keys")
    
    override func viewDidLoad() {
        let itemsRef = ref.child("C")
        print(itemsRef)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
