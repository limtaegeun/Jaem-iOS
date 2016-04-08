//
//  PanGestureInteractionController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 8..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

enum Direction {
    case Left, Right, Up, Down
    
    var pointVector: CGPoint {
        switch self {
        case Left: return CGPoint(x: -1, y: 0)
        case Right: return CGPoint(x: 1, y: 0)
        case Up: return CGPoint(x: 0, y: -1)
        case Down: return CGPoint(x: 0, y: 1)
        }
    }
    
    func panDistanceForView(view: UIView) -> CGPoint {
        switch self {
        case .Left:
            return CGPoint(x: -view.bounds.size.width, y: 0)
        case .Right :
            return CGPoint(x: view.bounds.size.width, y: 0)
        case .Up :
            return CGPoint(x: 0, y: -view.bounds.size.height)
        case .Down :
            return CGPoint(x: 0, y: view.bounds.size.height)
        
        }
    }
}

protocol PanGestureInteractionControllerDelegate : class {
    func didBeginPanning()
}

class PanGestureInteractionController: UIPercentDrivenInteractiveTransition {
    struct Callbacks {
        var didBeginPanning: (() -> Void)? = nil
    }
    var callbacks = Callbacks()
    var panGestureRecognizer : UIPanGestureRecognizer
    
    var delegate : PanGestureInteractionControllerDelegate?
    private var direction : Direction
    
    init(view: UIView, direction: Direction) {
        
        
        self.direction = direction
        panGestureRecognizer = UIPanGestureRecognizer()
        view.addGestureRecognizer(panGestureRecognizer)
        
        super.init()
        
        panGestureRecognizer.delegate = self
        panGestureRecognizer.addTarget(self, action: #selector(PanGestureInteractionController.viewPanned))
        
    }
    
    func viewPanned(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            delegate?.didBeginPanning()
        case .Changed:
            updateInteractiveTransition(percentCompleteForTranslation(sender.translationInView(sender.view)))
        case .Ended:
            if  percentComplete > 0.25 {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
        case .Cancelled:
            cancelInteractiveTransition()
        default:
            return
        }
    }
    
    func percentCompleteForTranslation(translation : CGPoint) -> CGFloat {
        let panDistance = direction.panDistanceForView(panGestureRecognizer.view!)
        
        switch direction {
        case .Left:
            return (translation.x * panDistance.x) / (panDistance.x * panDistance.x)
        case .Right :
            return (translation.x * panDistance.x) / (panDistance.x * panDistance.x)
        case .Up :
            return (translation.y * panDistance.y) / (panDistance.y * panDistance.y)
        case .Down :
            return (translation.y * panDistance.y) / (panDistance.y * panDistance.y)
        
        
        }
    }
    
    
    
}

extension PanGestureInteractionController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        return panGestureRecognizer.shouldRecognizeForDirection(direction)
    }
}








