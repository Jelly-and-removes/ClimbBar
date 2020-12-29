//
//  ClimbBar.swift
//  ClimbBar
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit.UIGestureRecognizer

// swiftlint:disable all
public class ClimbBar: NSObject {
    public var observer: ((State) -> Void)?

    var defaultContentOffset: CGPoint
    var defaultInset: UIEdgeInsets
    var configurations: Configuration!
    var scrollable: UIScrollView!
    var beginDrag: CGFloat
    var previousState: CGFloat!
    public var isReachable: Bool = false
    var climbBarObservable: ClimbBarObservable

    public struct State {
        var configuration: Configuration
        var begin: CGFloat
        var offset: CGPoint
        var origin: CGPoint

        init(conf: Configuration,
             begin: CGFloat,
             offset: CGPoint,
             origin: CGPoint)
        {
            configuration = conf
            self.begin = begin
            self.offset = offset
            self.origin = origin
        }
    }

    public init(configurations: Configuration!,
                scrollable: UIScrollView!)
    {
        self.configurations = configurations
        self.scrollable = scrollable
        beginDrag = 0
        defaultContentOffset = .zero
        defaultInset = .zero

        climbBarObservable = ClimbBarObservable(key: #keyPath(UIScrollView.contentOffset), object: self.scrollable)

        super.init()
        self.scrollable.delegate = self
        climbBarObservable.observer = { [weak self] _ in
            guard let self = self else { return }
            let state = State(conf: self.configurations,
                              begin: self.beginDrag,
                              offset: self.scrollable.contentOffset,
                              origin: self.scrollable.frame.origin)
            guard !self.isReachable else { return }
            self.observer?(state)
            self.previousState = state.originY
        }

        scrollable.panGestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))

        configuration(conf: configurations)
    }

    private func configuration(conf: Configuration) {
        previousState = conf.compact
        defaultContentOffset = CGPoint(x: 0, y: -conf.normal)
        defaultInset = UIEdgeInsets(top: conf.normal,
                                    left: scrollable.contentInset.left,
                                    bottom: scrollable.contentInset.bottom,
                                    right: scrollable.contentInset.right)

        if scrollable.contentInsetAdjustmentBehavior == .never {
            setScrollable(contentInset: defaultInset, contentOffset: defaultContentOffset)
        }
    }

    private func setScrollable(contentInset: UIEdgeInsets,
                               contentOffset: CGPoint)
    {
        scrollable.contentInset = contentInset
        scrollable.contentOffset = contentOffset
    }

    @objc private func handleGesture(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            isReachable = false
            beginDrag = scrollable.contentOffset.y
            configurations.currentStatus = previousState
        case .ended:
            /*
             * If the start and stop times are less than or equal to zero,
             * the movement is stopped.
             */
            if beginDrag < 0 {
                isReachable = true
            }
        case .possible, .changed, .cancelled, .failed:
            break
        @unknown default:
            break
        }
    }
}

extension ClimbBar: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isReachable = false
    }
}
// swiftlint:enable all
