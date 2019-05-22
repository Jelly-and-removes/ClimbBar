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
        if self.navigationBar.titleTextAttributes == nil {
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackAlpha]
        } else {
            self.navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] = blackAlpha
        }
        self.navigationBar.tintColor = self.navigationBar.tintColor.withAlphaComponent(alpha)
    }
}
