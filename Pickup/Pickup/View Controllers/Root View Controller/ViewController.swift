//
//  ViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 2/16/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
//Setting up the table view

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CALayerDelegate {
    
    struct MenuItem {
        var id : Int
        var title : String
        var description : String
        var call : String
        var more : String
        var image : UIImage!
        var labelColor : String
    }
    
    var menu = [
        MenuItem(id: 0, title: "Learning mode", description: "Play root notes into your phone and learn what scales fit over custom chord progressions.", call: "Start now", more: "Learn more", image: UIImage(named: "learningMode"), labelColor: "purple"),
        MenuItem(id: 1, title: "Free play", description: "Learning mode, without quizzes or questions. Just hop in and jam!", call: "Start now", more: "Learn more", image: UIImage(named: "freePlay"), labelColor: "yellow"),
        MenuItem(id: 2, title: "Metronome", description: "Get some work in playing in time after you’ve studied your scales.", call: "Start now", more: "Learn more", image: UIImage(named: "metronome"), labelColor: "green")
    ]
    
    @IBOutlet weak var homeTableView: UITableView!
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        //Cell styles
        cell.cellBackground.layer.shadowColor = UIColor.gray.cgColor
        cell.cellBackground.layer.shadowOffset = CGSize(width: 2, height: 4)
        cell.cellBackground.layer.shadowOpacity = 0.7
        
        
        //Set cell values here
        cell.titleCell.text = menu[indexPath.row].title
        cell.descCell.text = menu[indexPath.row].description
        cell.cellBackground.image = menu[indexPath.row].image
        cell.cellBackground.clipsToBounds = true
        cell.cellBackground.layer.cornerRadius = 20
        cell.layer.borderWidth = 20
        cell.layer.borderColor = UIColor.clear.cgColor
        
        if (menu[indexPath.row].id == 0) {
            //I'm going to try to add a custom button here for the cell
            let firstButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
            firstButton.center = CGPoint(x: cell.bounds.width / 2, y: (cell.bounds.height / 4) * 3)
            firstButton.setTitle("Build Progression", for: .normal)
            firstButton.setTitleColor(UIColor.black, for: .normal)
            firstButton.backgroundColor = UIColor.white
            firstButton.layer.shadowColor = UIColor.black.cgColor
            firstButton.layer.shadowOffset = CGSize(width: 1, height: 3)
            firstButton.layer.shadowOpacity = 0.1
            firstButton.layer.shadowRadius = 5
            firstButton.showsTouchWhenHighlighted = false
            firstButton.layer.cornerRadius = 15
            
            //target code
            firstButton.addTarget(self, action: #selector(sendToBuildProg), for: .touchUpInside)
            cell.addSubview(firstButton)
        }
        
        else if (menu[indexPath.row].id == 1) {
            //I'm going to try to add a custom button here for the cell
            let secondButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
            secondButton.center = CGPoint(x: cell.bounds.width / 2, y: (cell.bounds.height / 4) * 3)
            secondButton.setTitle("Start Free Play", for: .normal)
            secondButton.setTitleColor(UIColor.black, for: .normal)
            secondButton.backgroundColor = UIColor.white
            secondButton.layer.shadowColor = UIColor.black.cgColor
            secondButton.layer.shadowOffset = CGSize(width: 1, height: 3)
            secondButton.layer.shadowOpacity = 0.1
            secondButton.layer.shadowRadius = 5
            secondButton.showsTouchWhenHighlighted = false
            secondButton.layer.cornerRadius = 15
            
            //target code
            secondButton.addTarget(self, action: #selector(sendToFreePlay), for: .touchUpInside)
            cell.addSubview(secondButton)
        }
        
        else if (menu[indexPath.row].id == 2) {
            //I'm going to try to add a custom button here for the cell
            let thirdButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
            thirdButton.center = CGPoint(x: cell.bounds.width / 2, y: (cell.bounds.height / 4) * 3)
            thirdButton.setTitle("Open Metronome", for: .normal)
            thirdButton.setTitleColor(UIColor.black, for: .normal)
            thirdButton.backgroundColor = UIColor.white
            thirdButton.layer.shadowColor = UIColor.black.cgColor
            thirdButton.layer.shadowOffset = CGSize(width: 1, height: 3)
            thirdButton.layer.shadowOpacity = 0.1
            thirdButton.layer.shadowRadius = 5
            thirdButton.showsTouchWhenHighlighted = false
            thirdButton.layer.cornerRadius = 15
            
            //target code
            thirdButton.addTarget(self, action: #selector(sendToMetronome), for: .touchUpInside)
            cell.addSubview(thirdButton)
        }
        
        return cell
    }
    
    @objc func sendToBuildProg(_ sender: Any) {
        print("Send to build progression")
        let storyboard: UIStoryboard = UIStoryboard(name: "Learning1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningViewController
        self.show(vc, sender: self)
        print("Success")
    }
    
    @objc func sendToFreePlay(_ sender: Any) {
        print("Send to free play")
    }

    @objc func sendToMetronome(_ sender: Any) {
        print("Send to metronome")
    }
    

    private var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        let gradientView = UIView(frame: homeTableView.bounds)
        gradient = CAGradientLayer()
        gradient.delegate = self
        
        gradient.frame = homeTableView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.9)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
//        view.layer.insertSublayer(gradient, at: 0)
        
        self.homeTableView.layer.mask = gradient
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateGradientFrame()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateGradientFrame()
    }
    
    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return NSNull()
    }
    
    private func updateGradientFrame() {
        gradient.frame = CGRect(
            x: 0,
            y: homeTableView.contentOffset.y,
            width: homeTableView.bounds.width,
            height: homeTableView.bounds.height
        )
    }



}

