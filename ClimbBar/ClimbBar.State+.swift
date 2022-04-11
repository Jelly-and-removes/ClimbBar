//
//  ClimbReducer.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/19/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation

public extension ClimbBar.State {

    /*
     * originY of scrollable View
     * Pass this value to scrollable origin.y
     * return CGFloat
     */
    var originY: CGFloat {
        let diffVal = configuration.currentStatus + begin - offset.y
        return min(max(diffVal, configuration.lower), configuration.upper)
    }

    /*
     * Size between lower value and upper value specified in Configuration.
     */
    var height: CGFloat {
        (originY + configuration.climbRange) - origin.y
    }

    /*
     * Lower and Upper values specified in Configurations,
     * reduced from the lower and upper values.
     */
    var distance: CGFloat {
        height - configuration.compact
    }

    /*
     * Outputs the percentage of progress from the lower value to the upper value
     * since the start of scrolling, as a number between 1.0 and 0.
     */
    var progress: CGFloat {
        CGFloat((height - configuration.compact) / configuration.climbRange)
    }

    /*
     * Outputs the percentage of progress from the lower value to the upper value
     * since the start of scrolling, as a number between 0 and 1.0
     */
    var reversProgress: CGFloat {
        (progress - 1) * -1
    }
}
