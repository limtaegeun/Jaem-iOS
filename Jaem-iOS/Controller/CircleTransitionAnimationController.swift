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
        
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BodyViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! RegularFitViewController
        let circleView = fromViewController.LeftCircleView
        containerView!.addSubview(toViewController.view)
        
        let circleMaskPathInitial = UIBezierPath(ovalInRect: circleView.frame)
        let extremePoint = CGPoint(x: circleView.center.x - 0, y: circleView.center.y - CGRectGetHeight(toViewController.view.bounds))
        let radius = sqrt((extremePoint.x * extremePoint.x ) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(circleView.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.circleTransitionContext?.completeTransition(!self.circleTransitionContext!.transitionWasCancelled())
        self.circleTransitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }

}
