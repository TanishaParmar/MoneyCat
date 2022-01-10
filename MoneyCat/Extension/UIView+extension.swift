//
//  UIView+extension.swift
//  MoneyCat
//
//  Created by MyMac on 1/3/22.
//

import Foundation
import UIKit


extension UIView {
//   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
//        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
//        let topRightRadius = CGSize(width: topRight, height: topRight)
//        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
//        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
//        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeft, topRightRadius: topRight, bottomLeftRadius: bottomLeft, bottomRightRadius: bottomRight)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}



extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

