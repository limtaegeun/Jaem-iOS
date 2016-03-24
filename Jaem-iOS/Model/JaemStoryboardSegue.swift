//
//  JaemStoryboardSegue.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 21..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class JaemStoryboardSegue: UIStoryboardSegue {
    
    
    override func perform() {
        
        let tabBarController = self.sourceViewController as! CardStackViewController
        let destinationController = self.destinationViewController as! UINavigationController
        
        for view in tabBarController.placeholderView.subviews as [UIView] {
            view.removeFromSuperview()
            
        }
        
        tabBarController.currentViewController = destinationController
        tabBarController.placeholderView.addSubview(destinationController.view)
        tabBarController.naviBar = destinationController.navigationBar
        
        tabBarController.placeholderView.translatesAutoresizingMaskIntoConstraints = false
        destinationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(verticalConstraint)
        
        tabBarController.placeholderView.layoutIfNeeded()
        destinationController.didMoveToParentViewController(tabBarController)
    }
}
