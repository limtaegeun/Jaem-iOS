//
//  SearchResultCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var clothesImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addAccView: AddButtonView!
    
    var downloadTask : NSURLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForImageResult(urlPath : String)  {
        if let url = NSURL(string: urlPath) {
            downloadTask = clothesImage.loadImageWithURL(url, saveData: nil)
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if downloadTask != nil {
            downloadTask?.cancel()
            downloadTask = nil
            
        }
        
        clothesImage.image = nil
        brandLabel.text = nil
        nameLabel.text = nil
    }
    
}
