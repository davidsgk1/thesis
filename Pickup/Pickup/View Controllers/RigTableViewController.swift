//
//  RigTableViewController.swift
//  
//
//  Created by Keegan Davidson on 4/21/19.
//

import UIKit
import Firebase

class RigTableViewController: UITableViewController {
    //Setting values
    var items: [RigItem] = []
    let ref = Database.database().reference(withPath: "rig-items")

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            var newItems: [RigItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let rigItem = RigItem(snapshot: snapshot) {
                    newItems.append(rigItem)
                }
            }
        self.items = newItems
        self.tableView.reloadData()
        })
        
    }
    
    //Send them to the detail view on click
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Rig", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RigDetailViewController") as! RigDetailViewController
        let currentItem = items[indexPath.row]
        
        vc.type = currentItem.type
        vc.name = currentItem.name
        vc.color = currentItem.color
        vc.year = currentItem.year
        vc.serialNum = currentItem.serialNum
        vc.extras = currentItem.extras
        
        self.show(vc, sender: self)
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(items.count)
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        let currentItem = items[indexPath.row]
        
//        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: sWidth, height: sHeight/5))
//        nameLabel.center = CGPoint(x: sWidth/2, y: sHeight/5)
//        nameLabel.textAlignment = .center
//        nameLabel.text = currentItem.name
//        cell.addSubview(nameLabel)
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = currentItem.year

        // Configure the cell...

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeItem = items[indexPath.row]
            removeItem.ref?.removeValue()
            tableView.reloadData()
        }
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
