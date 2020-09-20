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
        let diffVal = configuration.currentStatus + begin - offset.y
        return min(max(diffVal, configuration.lower), configuration.upper)
    }

    public var height: CGFloat {
        return (originY + configuration.climbRange) - origin.y
    }

    public var distance: CGFloat {
        return height - configuration.compact
    }

    public var progress: CGFloat {
        return CGFloat((height - configuration.compact) / configuration.climbRange)
    }
}
