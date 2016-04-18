//
//  UIImageView+DownloadImage.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 18..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

extension UIImageView {
    
    func loadImageWithURL(url: NSURL, saveData : (save : Bool, fileName: String)? ) -> NSURLSessionDownloadTask {
        let session = NSURLSession.sharedSession()
        let downloadTask = session.downloadTaskWithURL(url) {  [weak self] url, response, error  in
            if error == nil && url != nil {
                if let data = NSData(contentsOfURL: url!) {
                    if let image = UIImage(data: data) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if let strongSelf = self {
                                strongSelf.image = image
                                
                                
                            }
                        })
                        
                    }
                }
            }
            
        }
        downloadTask.resume()
        return downloadTask
    }
}