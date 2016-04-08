//
//  UIPanGestureRecognizer+Direction.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 8..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

extension UIPanGestureRecognizer {
    func shouldRecognizeForDirection(direction : Direction) -> Bool {
        guard let view = view else {
            return false
        }
        let velocity = velocityInView(view)
        
        let v1 = CGVector(dx: velocity.x, dy: velocity.y)
        let v2 = CGVector(dx: direction.pointVector.x, dy: direction.pointVector.y)
        
        let angle = atan2(v1.dy, v2.dx) - atan2(v2.dy, v2.dx)
        print(abs(angle) < CGFloat(M_PI_4 * 1.5 ))
        return abs(angle) < CGFloat(M_PI_4 * 1.5)
    }
}
