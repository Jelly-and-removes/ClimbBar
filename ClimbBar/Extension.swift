//
//  ClimbReducer.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/19/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation

public extension ClimbBar.State {
    var originY: CGFloat {
        let diffVal = configuration.currentStatus + begin - offset.y
        return min(max(diffVal, configuration.lower), configuration.upper)
    }

    var height: CGFloat {
        (originY + configuration.climbRange) - origin.y
    }

    var distance: CGFloat {
        height - configuration.compact
    }

    var progress: CGFloat {
        CGFloat((height - configuration.compact) / configuration.climbRange)
    }

    var reversProgress: CGFloat {
        (progress - 1) * -1
    }
}
