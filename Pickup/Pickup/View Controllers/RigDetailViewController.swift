//
//  RigDetailViewController.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/21/19.
//  Copyright © 2019 AudioKit. All rights reserved.
//

import UIKit
@IBDesignable

class RigDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var type = ""
    var name = ""
    var color = ""
    var year = ""
    var serialNum = ""
    var extras = ""
    
    @IBOutlet weak var descView: UIView!
    
    //Setting up image capturing
    @IBOutlet weak var detailImage: UIImageView!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpLabels()
        setUpDetailImage()
    }
    
    @IBAction func addImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        detailImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
    }
    
    func setUpDetailImage() {
        if (detailImage.image == nil) {
            detailImage.image = UIImage(named: "noImageFound")
        }
    }
    
    func setUpLabels() {
        let sHeight = self.view.frame.height
        let sWidth = self.view.frame.width
        
        let labelFrame = CGRect(x: 0, y: 0, width: sWidth - 50, height: sHeight / 15)
        let typeLabel = UILabel(frame: labelFrame)
        typeLabel.text = name
        typeLabel.center = CGPoint(x: sWidth/2, y: (sHeight/10) * 2)
        typeLabel.font = typeLabel.font.withSize(20)
        self.view.addSubview(typeLabel)
        
        let subH = descView.frame.height
        let subW = descView.frame.width
        
        let subLabelFrame = CGRect(x: 0, y: 0, width: subW - 50, height: subH / 7)
        for i in 0...4 {
            let thisLabel = UILabel(frame: subLabelFrame)
            thisLabel.center = CGPoint(x: subW / 2, y: (subH / 7) * CGFloat(i))
            thisLabel.textAlignment = .left
            switch (i) {
            case 0:
                thisLabel.text = name
            case 1:
                thisLabel.text = color
            case 2:
                thisLabel.text = year
            case 3:
                thisLabel.text = serialNum
            case 4:
                thisLabel.text = extras
                thisLabel.numberOfLines = 3
            default:
                thisLabel.text = "Could not add."
            }
            descView.addSubview(thisLabel)
        }
        descView.isHidden = false
        
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
