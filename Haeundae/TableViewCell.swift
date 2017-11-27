//
//  TableViewCell.swift
//  Haeundae
//
//  Created by D7703_29 on 2017. 11. 23..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var adr: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
