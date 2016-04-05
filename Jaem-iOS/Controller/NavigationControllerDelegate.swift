//
//  NavigationControllerDelegate.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 5..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject , UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
