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

    //193
    //130
    //204

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelectionDuringEditing = false
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 193/255.0, green: 130/255.0, blue: 204/255.0, alpha: 1.0)
        
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
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RigTableViewCell
    
        let currentItem = items[indexPath.row]
        
        cell.titleLabel?.text = currentItem.name
        cell.descLabel?.text = currentItem.year + " " + currentItem.type

        var type = currentItem.type.lowercased()
        if (type.contains("guitar")) {
            let guitar = UIImage(named: "guitarRig")
            cell.thumbnail.image = guitar
        }
        else if (type.contains("pedal")) {
            let pedal = UIImage(named: "pedalRig")
            cell.thumbnail.image = pedal
        }
        else if (type.contains("amp") || type.contains("speaker") || type.contains("cabinet")) {
            let amp = UIImage(named: "ampRig")
            cell.thumbnail.image = amp
        }
        else {
            let misc = UIImage(named: "miscRig")
            cell.thumbnail.image = misc
        }
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
