//
//  Configurations.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

public struct Configuration {
    
    var compact: CGFloat = 0
    var normal: CGFloat = 0
    var climbRange:CGFloat = 0
    var lower: CGFloat = 0
    var upper: CGFloat = 0
    var currentStatus: CGFloat = 0
    var topDistance: CGFloat = 0
    
    public init(range: Range<CGFloat>) {
        self.compact = range.lowerBound
        self.normal = range.upperBound
        self.climbRange = (compact - normal) * -1        
        self.lower = compact - self.climbRange
        self.upper = normal - self.climbRange
        self.currentStatus = self.compact
        self.topDistance = self.normal
    }
}
