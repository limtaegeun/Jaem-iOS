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
        
        //set View
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CardTabBarController
        if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? RegularFitViewController {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            let naviVC = fromViewController.viewControllers?.first as! UINavigationController
            let bodyVC = naviVC.topViewController as! BodyViewController
            let AvatarView = bodyVC.AvatarView
            let circleView = bodyVC.LeftCircleView
            
            containerView!.addSubview(toView!)
            
            //set MaskPath
            let pathframe = CGRectOffset(circleView.frame, 0, AvatarView.frame.origin.y)
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
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.circleTransitionContext?.completeTransition(!self.circleTransitionContext!.transitionWasCancelled())
        self.circleTransitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }

}
