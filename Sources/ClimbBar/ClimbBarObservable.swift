//
//  KVOContextObservable.swift
//  AirBar
//
//  Created by Евгений Матвиенко on 6/23/17.
//  Copyright © 2017 uptechteam. All rights reserved.
//

import CoreGraphics.CGGeometry
import Foundation

// swiftlint:disable all
internal class ClimbBarObservable: NSObject {
    private let key: String
    private weak var object: AnyObject?
    private var observingContext = NSUUID().uuidString
    internal var observer: ((CGPoint) -> Void)?

    internal init(key: String, object: AnyObject) {
        self.key = key
        self.object = object
        super.init()

        object.addObserver(self, forKeyPath: key,
                           options: [.new],
                           context: &observingContext)
    }

    deinit {
        object?.removeObserver(self, forKeyPath: key,
                               context: &observingContext)
    }

    override func observeValue(forKeyPath _: String?,
                               of _: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        guard context == &observingContext,
              let newValue = change?[NSKeyValueChangeKey.newKey] as? CGPoint
        else {
            return
        }
        observer?(newValue)
    }
}
// swiftlint:disable all
