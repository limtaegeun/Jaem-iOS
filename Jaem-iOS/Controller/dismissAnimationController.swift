//
//  dismissAnimationController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class dismissAnimationController: NSObject , UIViewControllerAnimatedTransitioning{

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)  {
            if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)  {
                fromView.frame = transitionContext.finalFrameForViewController(fromViewController)
                
                
                
                UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    fromView.frame.origin.y += fromViewController.view.frame.height
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(finished)
                })
            }
        }
    }
}
