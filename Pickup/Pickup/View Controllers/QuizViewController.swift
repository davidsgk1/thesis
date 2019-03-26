//
//  QuizViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 3/25/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuizViewController: UIViewController {
    
    var ref: DatabaseReference!
//    var databaseHandle: DatabaseHandle!
    static var chordsArr: [String] = []
    
    func runDBData() {
        ref = Database.database().reference()
        
        ref.child("keys").child("CSharp").observeSingleEvent(of: .value, with: {(snapshot) in
            //Take data from the snapshot and add it to the chords array
            //            let chord = snapshot as? String
            print("Ref is running")
            let dict = snapshot.value as? NSDictionary
            let chords = dict!["chords"] as! [String]
            for chord in chords {
                QuizViewController.chordsArr.append(chord)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
//        runDBData { ([String]) in
//            for chord in chordsArr {
//                print(chord)
//            }
//        }
        runDBData()
        super.viewDidLoad()
    }
    

}
