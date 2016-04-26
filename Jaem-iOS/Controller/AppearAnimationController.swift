//
//  AppearAnimationController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class AppearAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // slide appear
        
        if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? ClosetDetailViewController {
            if let toView = transitionContext.viewForKey(UITransitionContextToViewKey) {
                toView.frame = transitionContext.finalFrameForViewController(toViewController)
                let finalFrame = toView.frame
                
                let containerview = transitionContext.containerView()
                containerview!.addSubview(toView)
                
                toView.frame.origin.y = toViewController.view.frame.height
                
                
                UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    toView.frame = finalFrame
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(finished)
                })
            }
        }
    }
}
