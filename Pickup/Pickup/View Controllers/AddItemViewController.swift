//
//  AddItemViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 4/22/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {
    
    //Setting up db connection
    let ref = Database.database().reference(withPath: "rig-items")
    
    
    @IBOutlet weak var gearName: UITextField!
    @IBOutlet weak var gearType: UITextField!
    @IBOutlet weak var gearYear: UITextField!
    @IBOutlet weak var gearColor: UITextField!
    @IBOutlet weak var gearSerialNum: UITextField!
    @IBOutlet weak var gearExtras: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButton()
        
    }
    
    func addButton() {
        let sWidth = self.view.frame.width
        let sHeight = self.view.frame.height
        
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        addButton.center = CGPoint(x: sWidth/2, y: (sHeight/10)*8)
        addButton.setTitle("Add Item", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        addButton.layer.shadowOpacity = 0.2
        addButton.layer.shadowRadius = 5
        addButton.showsTouchWhenHighlighted = false
        //Add Target Code
        addButton.addTarget(self, action: #selector(addItemToFirebase), for: .touchUpInside)
        addButton.layer.cornerRadius = 15
        self.view.addSubview(addButton)
    }
    
    @objc func addItemToFirebase() {
        print("Add Item")
        let name = gearName.text
        let type = gearType.text
        let year = gearYear.text
        let color = gearColor.text
        var serialNum = gearSerialNum.text
        var extras = gearExtras.text
        
        if (name == nil) {
            let alert = UIAlertController(title: "Hold up!", message: "Please enter a name.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (type == nil) {
            let alert = UIAlertController(title: "Hold up!", message: "Please enter a type for your gear (like electric guitar).", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (year == nil) {
            let alert = UIAlertController(title: "Hold up!", message: "Please enter a production year.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (color == nil) {
            let alert = UIAlertController(title: "Hold up!", message: "Please enter a color or finish for your gear.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (serialNum == nil) {
            serialNum = "Unknown serial #"
        }
        else if (extras == nil) {
            extras = ""
        }
        let newItem = RigItem(type: type!, name: name!, color: color!, year: year!, serialNum: serialNum!, extras: extras!)
        let rigItemsRef = self.ref.child(name!.lowercased())
        rigItemsRef.setValue(newItem.toAnyObject())
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Rig", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RigNavViewController") as! UINavigationController
        self.show(vc, sender: self)
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
