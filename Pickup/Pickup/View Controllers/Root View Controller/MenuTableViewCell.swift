//
//  MenuTableViewCell.swift
//  
//
//  Created by Keegan Davidson on 2/26/19.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
