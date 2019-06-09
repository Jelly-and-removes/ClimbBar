//
//  ClimbReducer.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/19/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation

class Calculate {
    
    var configuration: Configuration
    var begin: CGFloat
    var offset: CGPoint
    var origin: CGPoint
    
    init(conf: Configuration,
         begin: CGFloat,
         offset: CGPoint,
         origin: CGPoint) {
        
        self.configuration = conf
        self.begin = begin
        self.offset = offset
        self.origin = origin
    }
    
    var originY: CGFloat {
        let diffVal = self.configuration.currentStatus + begin - offset.y
        return min(max(diffVal, self.configuration.lower), self.configuration.upper)
    }
    
    var height: CGFloat {
        return (self.originY + self.configuration.climbRange) - origin.y
    }
    
    var distance: CGFloat {
        return self.height - self.configuration.compact
    }
    
    var alpha: CGFloat {
        return CGFloat((self.height - self.configuration.compact) / self.configuration.climbRange)
    }
}
