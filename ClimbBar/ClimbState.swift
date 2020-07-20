//
//  ClimbState.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/10/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

public class State {

    public var origin: CGPoint?
    public var size: CGSize?
    public var conf: Configuration?
    public var pbState: CGFloat = 0
    public var defaultContentOffset: CGPoint = .zero
    public var defaultInset: UIEdgeInsets = .zero
    var currentState: CGFloat = 0

    init(configurations: Configuration,
         origin: CGPoint,
         size: CGSize) {
        self.conf = configurations
        self.origin = origin
        self.size = size
        self.pbState = conf!.compact
    }
}
