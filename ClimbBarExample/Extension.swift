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
