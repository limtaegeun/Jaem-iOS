//
//  PeripheralCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 29..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class PeripheralCell: UITableViewCell {

    @IBOutlet weak var localNameLabel: UILabel!
    @IBOutlet weak var manufacturerKeyLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
