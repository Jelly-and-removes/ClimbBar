//
//  ClimbBar.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit.UIGestureRecognizer

public class ClimbBar: NSObject {

    public var defaultContentOffset: CGPoint
    public var defaultInset: UIEdgeInsets
    public var observer: ((State) -> Void)?
    public var defaultContentOffsetY: CGFloat {
        return self.defaultContentOffset.y
    }

    var configurations: Configuration!
    var scrollable: UIScrollView!
    var beginDrag: CGFloat
    var previousState: CGFloat!
    var isReachable: Bool = false
    var climbBarObservable: ClimbBarObservable

    public struct State {
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
    }
    
    public init(configurations: Configuration!,
                scrollable: UIScrollView!) {
        self.configurations = configurations
        self.scrollable = scrollable
        self.beginDrag = 0
        self.defaultContentOffset = .zero
        self.defaultInset = .zero

        climbBarObservable = ClimbBarObservable(key: #keyPath(UIScrollView.contentOffset), object: self.scrollable)

        super.init()

        climbBarObservable.observer = { [weak self] value in
            guard let self = self else { return }
            let state = State(conf:   self.configurations,
                              begin:  self.beginDrag,
                              offset: self.scrollable.contentOffset,
                              origin: self.scrollable.frame.origin)
            guard self.isReachable == false else { return }
            self.observer?(state)
            self.previousState = state.originY
        }

        scrollable.panGestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))

        self.configuration(conf: configurations)
    }

    private func configuration (conf: Configuration) {
        self.previousState = conf.compact
        self.defaultContentOffset = CGPoint(x: 0, y: -conf.topDistance)
        self.defaultInset = UIEdgeInsets(top:    conf.topDistance,
                                         left:   self.scrollable.contentInset.left,
                                         bottom: self.scrollable.contentInset.bottom,
                                         right:  self.scrollable.contentInset.right)

        if self.scrollable.contentInsetAdjustmentBehavior == .never {
            self.setScrollable(contentInset: self.defaultInset, contentOffset: self.defaultContentOffset)
        }
    }

    public func adjustScrollable(){
        self.setScrollable(contentInset: self.defaultInset,
                           contentOffset: self.defaultContentOffset)
    }

    private func setScrollable(contentInset: UIEdgeInsets,
                               contentOffset: CGPoint) {
        self.scrollable.contentInset = contentInset
        self.scrollable.contentOffset = contentOffset
    }

    @objc private func handleGesture (_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.isReachable = false
            self.beginDrag = self.scrollable.contentOffset.y
            self.configurations.currentStatus = self.previousState
            break
        case .ended:
            /*
             * If the start and stop times are less than or equal to zero,
             * the movement is stopped.
             */
            if self.beginDrag < 0 {
                self.isReachable = true
            }
        case .possible, .changed, .cancelled, .failed:
            break
        @unknown default:
            break
        }
    }
}
