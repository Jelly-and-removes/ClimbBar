//
//  ClimbReducer.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/19/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation

extension ClimbBar.State {
    public var originY: CGFloat {
        let diffVal = self.configuration.currentStatus + self.begin - self.offset.y
        return min(max(diffVal, self.configuration.lower), self.configuration.upper)
    }

    public var height: CGFloat {
        return (self.originY + self.configuration.climbRange) - self.origin.y
    }

    public var distance: CGFloat {
        return self.height - self.configuration.compact
    }

    public var progress: CGFloat {
        return CGFloat((self.height - self.configuration.compact) / self.configuration.climbRange)
    }
}
