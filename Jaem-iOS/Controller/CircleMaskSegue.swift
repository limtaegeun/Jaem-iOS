//
//  CircleMaskSegue.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 8..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CircleMaskSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    
    @IBInspectable var direction : Direction!
    //var presentationController : = nil
    
    override func perform() {
        destinationViewController.modalPresentationStyle = .Custom
        destinationViewController.transitioningDelegate = self
        super.perform()
    }
    
    //MARK : UIviewControllerTransitioningDelegate
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        let sourceVC = sourceViewController as! BodyViewController
        return PanGestureInteractionController(view: sourceVC.AvatarView, direction: Direction.Right)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimationController()
    }
    
    
     
     func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CirclePresentationController(presentedViewController: presented, presentingViewController: presenting)

     }
    
    
}
