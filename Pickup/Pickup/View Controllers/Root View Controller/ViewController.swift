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
    }
    
    var menu = [
        MenuItem(id: 0, title: "LEARNING MODE", description: "Lorem ipsum dude", call: "Start now", more: "Learn more"),
        MenuItem(id: 1, title: "FREE PLAY", description: "Moresum Lorem ipsum dog", call: "Start now", more: "Learn more"),
        MenuItem(id: 2, title: "METRONOME", description: "There's going to be a metronome here, I promise dude. Just give me time.", call: "Start now", more: "Learn more")
    ]
    
    @IBOutlet weak var homeTableView: UITableView!
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
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
        
        //Set cell values here
        cell.titleCell.text = menu[indexPath.row].title
        cell.descCell.text = menu[indexPath.row].description
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        print(menu[indexPath.row].description)
        print(menu[indexPath.row].title)
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



}

