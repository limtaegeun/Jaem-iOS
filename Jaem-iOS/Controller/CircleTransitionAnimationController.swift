//
//  CircleTransitionAnimationController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 5..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CircleTransitionAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var circleTransitionContext : UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        circleTransitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as 
        
        containerView?.addSubview(toViewController!.view)
        
        var circleMaskPathInithal = UIBezierPath(ovalInRect: <#T##CGRect#>)
        
        
        
    }

}
