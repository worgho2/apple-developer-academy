//
//  TextTableViewCell.swift
//  Windows98Crash
//
//  Created by Otávio Baziewicz Filho on 16/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
