//
//  RigTableViewCell.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/22/19.
//  Copyright © 2019 AudioKit. All rights reserved.
//

import UIKit

class RigTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
