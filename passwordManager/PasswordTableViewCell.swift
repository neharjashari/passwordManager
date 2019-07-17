//
//  PasswordTableViewCell.swift
//  passwordManager
//
//  Created by Nehar Jashari on 17/07/2019.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myFirstCellLabel: UILabel!
    @IBOutlet weak var mySecondCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
