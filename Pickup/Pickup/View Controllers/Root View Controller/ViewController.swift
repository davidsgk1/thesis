//
//  ViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 2/16/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
//Setting up the table view

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        return 400.0
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
        
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



}

