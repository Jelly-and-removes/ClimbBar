//
//  Configurations.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

/*
 * Class to set how much range of scrolled values should be returned
 */
public struct Configuration {
    var compact: CGFloat = 0
    var normal: CGFloat = 0
    var climbRange: CGFloat = 0
    var lower: CGFloat = 0
    var upper: CGFloat = 0
    var currentStatus: CGFloat = 0

    public init(range: ClosedRange<CGFloat>) {
        compact = range.lowerBound
        normal = range.upperBound
        climbRange = (compact - normal) * -1
        lower = compact - climbRange
        upper = normal - climbRange
        currentStatus = compact
    }
}
