//
//  NoDeviceCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 27..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class NoDeviceCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sizeTextField: UITextField!
 
    override func prepareForReuse() {
        titleLabel.text = ""
        sizeTextField.placeholder = "__CM"
        sizeTextField.text = ""
        sizeTextField.userInteractionEnabled = true
        
    }
}
