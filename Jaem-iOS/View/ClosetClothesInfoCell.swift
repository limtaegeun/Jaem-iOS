//
//  ClosetClothesInfoCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 23..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ClosetClothesInfoCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cancelButton.setImage(JaemIconStyleKit.imageOfGrayFillCancel, forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
