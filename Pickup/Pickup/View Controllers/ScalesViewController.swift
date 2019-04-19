//
//  ScalesViewController.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/3/19.
//  Copyright © 2019 AudioKit. All rights reserved.
//

import UIKit
@IBDesignable

class ScalesViewController: UIViewController, UIScrollViewDelegate {
    
    //Instance variables from segue
    var scale = [String]()
    var scaleName = ""
    
    //Scale view
    @IBOutlet weak var grid: GridView!
    @IBOutlet weak var scrollView: UIScrollView!
    var posLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    
    var shapeHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sHeight = self.view.frame.size.height
        let sWidth = self.view.frame.size.width
        
        scrollView.delegate = self
        grid.scale = scale
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: grid.frame.size.height + 300)
//        scaleView.
        grid.isHidden = false
        
        
        
//        scaleNameLabel.text = scaleName
        
        
        shapeHeight = (grid.frame.size.height / 4.5)
        
        print(scale)
        print(scaleName)

        // Do any additional setup after loading the view.
        setUpNameLabel(str: scaleName)
        setUpBackButton()
        setUpScrollButtons()
        
        posLabel.center = CGPoint(x: sWidth/2, y: (sHeight/10)*2)
        posLabel.text = "Position 0"
        posLabel.textAlignment = .center
        posLabel.textColor = UIColor.black
        posLabel.numberOfLines = 1
        posLabel.adjustsFontSizeToFitWidth = false
        posLabel.font = posLabel.font.withSize(20)
        view.addSubview(posLabel)
        
    }
    
    func setUpScrollButtons() {
        let sHeight = self.view.frame.size.height
        let sWidth = self.view.frame.size.width
        
        //Down button
        let downButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        downButton.center = CGPoint(x: (sWidth/4) * 3, y: (sHeight/10)*2)
        let downArrow = UIImage(named: "downArrow")
        downButton.setImage(downArrow, for: .normal)
        downButton.backgroundColor = UIColor.clear
        downButton.showsTouchWhenHighlighted = false
        //Add target Code
        downButton.addTarget(self, action: #selector(scrollDown), for: .touchUpInside)
        self.view.addSubview(downButton)
        
        //Up Button
        let upButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        upButton.center = CGPoint(x: sWidth/4, y: (sHeight/10)*2)
        let upArrow = UIImage(named: "upArrow")
        upButton.setImage(upArrow, for: .normal)
        upButton.backgroundColor = UIColor.clear
        upButton.showsTouchWhenHighlighted = false
        //Add target Code
        upButton.addTarget(self, action: #selector(scrollUp), for: .touchUpInside)
        self.view.addSubview(upButton)
        
    }
    
    var posIndex = 0
    
    @objc func scrollDown(_ sender: Any) {
        
        if (posIndex == 0) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 1), animated: true)
            posIndex = 1
        }
        else if (posIndex == 1) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 2), animated: true)
            posIndex = 2
        }
        else if (posIndex == 2) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 3), animated: true)
            posIndex = 3
        }
        else if (posIndex == 3) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 4), animated: true)
            posIndex = 4
        }
        else if (posIndex == 4) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 5), animated: true)
            posIndex = 5
        }
        posLabel.text = "Position " + String(posIndex)
    }
    
    @objc func scrollUp(_ sender: Any) {
        
        if (posIndex == 5) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 4), animated: true)
            posIndex = 4
        }
        else if (posIndex == 4) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 3), animated: true)
            posIndex = 3
        }
        else if (posIndex == 3) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 2), animated: true)
            posIndex = 2
        }
        else if (posIndex == 2) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 1), animated: true)
            posIndex = 1
        }
        else if (posIndex == 1) {
            scrollView.setContentOffset(CGPoint(x: 0, y: shapeHeight * 0), animated: true)
            posIndex = 0
        }
        posLabel.text = "Position " + String(posIndex)
    }

    func setUpNameLabel(str: String) {
        let sHeight = self.view.frame.size.height
        let sWidth = self.view.frame.size.width
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (sWidth - 150), height: (sHeight/10)))
        nameLabel.center = CGPoint(x:sWidth/2, y: (sHeight/10)*1)
        nameLabel.textAlignment = .center
        nameLabel.text = str
        nameLabel.textColor = UIColor.black
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = false
        nameLabel.font = nameLabel.font.withSize(24)
        self.view.addSubview(nameLabel)
    }
    
    func setUpBackButton() {
        let sHeight = self.view.frame.size.height
        let sWidth = self.view.frame.size.width
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        backButton.center = CGPoint(x: sWidth/2, y: (sHeight/10)*1.5)
        backButton.setTitle("New Progression", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        backButton.layer.shadowColor = UIColor.gray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        backButton.layer.shadowOpacity = 0.3
        backButton.layer.shadowRadius = 5
        backButton.showsTouchWhenHighlighted = false
        backButton.layer.cornerRadius = 15
        //Add target Code
        backButton.addTarget(self, action: #selector(returnToMain), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    @objc func returnToMain(_ sender: Any) {
        print("Sending back to chord progression builder")
        let storyboard: UIStoryboard = UIStoryboard(name: "Learning1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningViewController
        self.show(vc, sender: self)
        print("Success")
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
