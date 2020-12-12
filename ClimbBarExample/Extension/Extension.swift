//
//  Extension.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setAlpha(alpha: CGFloat) {
        let blackAlpha = UIColor.black.withAlphaComponent(alpha)
        if navigationBar.titleTextAttributes == nil {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackAlpha]
        } else {
            navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] = blackAlpha
        }
        navigationBar.tintColor = navigationBar.tintColor.withAlphaComponent(alpha)
    }
}

extension UIApplication {
    static var statusBarFrame: CGRect {
        UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?
            .windows
            .filter({$0.isKeyWindow}).first?
            .windowScene?
            .statusBarManager?
            .statusBarFrame ?? .zero
    }
    
    static var statusBarHeight: CGFloat {
        statusBarFrame.size.height
    }
}

extension UINavigationController {
    var barHeight: CGFloat {
        navigationBar.frame.size.height
    }
}
