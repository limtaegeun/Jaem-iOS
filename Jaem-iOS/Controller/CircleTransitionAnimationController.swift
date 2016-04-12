//
//  CircleTransitionAnimationController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 5..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CircleTransitionAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var present : Bool!
    
    weak var circleTransitionContext : UIViewControllerContextTransitioning?
    
    init(present: Bool) {
        self.present = present
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        circleTransitionContext = transitionContext
        
        //set View
        let containerView = transitionContext.containerView()
        if present == true {
            // set present animation
            if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? RegularFitViewController {
                let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CardTabBarController
                let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
                let naviVC = fromViewController.viewControllers?.first as! UINavigationController
                let bodyVC = naviVC.topViewController as! BodyViewController
                let AvatarView = bodyVC.AvatarView
                let circleView = bodyVC.LeftCircleView
                
                containerView!.addSubview(toView!)
                
                
                //set MaskPath
                let pathframe = CGRectOffset(circleView.frame, 0, AvatarView.frame.origin.y - bodyVC.scrollView.contentOffset.y)
                let circleMaskPathInitial = UIBezierPath(ovalInRect: pathframe)
                let extremePoint = CGPoint(x: (toView?.bounds.width)!, y: circleView.center.y - CGRectGetHeight(toViewController.view.bounds))
                let radius = sqrt((extremePoint.x * extremePoint.x ) + (extremePoint.y * extremePoint.y))
                let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(circleView.frame, -radius, -radius))
                
                //set MaskLayer
                let maskLayer = CAShapeLayer()
                maskLayer.path = circleMaskPathFinal.CGPath
                toView!.layer.mask = maskLayer
                
                //set LayerAnimation
                let maskLayerAnimation = CABasicAnimation(keyPath: "path")
                maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
                maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
                maskLayerAnimation.duration = self.transitionDuration(transitionContext)
                maskLayerAnimation.delegate = self
                maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
            }
        }else {
            //set dismiss animation
            if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? CardTabBarController {
                //let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! RegularFitViewController
                let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
                let naviVC = toViewController.viewControllers?.first as! UINavigationController
                let bodyVC = naviVC.topViewController as! BodyViewController
                let AvatarView = bodyVC.AvatarView
                let circleView = bodyVC.LeftCircleView
                
                //set MaskPath
                let pathframe = CGRectOffset(circleView.frame, 0, AvatarView.frame.origin.y - bodyVC.scrollView.contentOffset.y)
                let circleMaskPathFinal = UIBezierPath(ovalInRect: pathframe)
                let extremePoint = CGPoint(x: (fromView?.bounds.width)!, y: circleView.center.y - CGRectGetHeight(fromView!.bounds))
                let radius = sqrt((extremePoint.x * extremePoint.x ) + (extremePoint.y * extremePoint.y))
                let circleMaskPathInitial = UIBezierPath(ovalInRect: CGRectInset(circleView.frame, -radius, -radius))
                
                //set MaskLayer
                let maskLayer = CAShapeLayer()
                maskLayer.path = circleMaskPathFinal.CGPath
                fromView!.layer.mask = maskLayer
                
                //set LayerAnimation
                let maskLayerAnimation = CABasicAnimation(keyPath: "path")
                maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
                maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
                maskLayerAnimation.duration = self.transitionDuration(transitionContext)
                maskLayerAnimation.delegate = self
                maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
            }
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.circleTransitionContext?.completeTransition(!self.circleTransitionContext!.transitionWasCancelled())
        self.circleTransitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }

}
