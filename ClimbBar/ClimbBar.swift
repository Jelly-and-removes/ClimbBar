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
    public var isReachable: Bool = false

    var _defaultContentOffset: CGPoint
    var _defaultInset: UIEdgeInsets
    var _configurations: Configuration!
    var _scrollable: UIScrollView!
    var _beginDrag: CGFloat
    var _previousState: CGFloat!
    var _climbBarObservable: ClimbBarObservable

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

    public init(configurations: Configuration,
                scrollable: UIScrollView)
    {
        self._configurations = configurations
        self._scrollable = scrollable
        _beginDrag = 0
        _defaultContentOffset = .zero
        _defaultInset = .zero

        _climbBarObservable = ClimbBarObservable(key: #keyPath(UIScrollView.contentOffset), object: self._scrollable)

        super.init()

        _climbBarObservable.observer = { [weak self] _ in
            guard let self = self else { return }
            let state = State(conf: self._configurations,
                              begin: self._beginDrag,
                              offset: self._scrollable.contentOffset,
                              origin: self._scrollable.frame.origin)
            guard !self.isReachable else { return }
            self.observer?(state)
            self._previousState = state.originY
        }

        scrollable.panGestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))

        setup(configurations)
    }

    private func setup(_ conf: Configuration) {
        _previousState = conf.compact
        _defaultContentOffset = CGPoint(x: 0, y: -conf.normal)
        _defaultInset = UIEdgeInsets(top: conf.normal,
                                    left: _scrollable.contentInset.left,
                                    bottom: _scrollable.contentInset.bottom,
                                    right: _scrollable.contentInset.right)

        if _scrollable.contentInsetAdjustmentBehavior == .never {
            setScrollable(contentInset: _defaultInset, contentOffset: _defaultContentOffset)
        }
    }

    private func setScrollable(contentInset: UIEdgeInsets,
                               contentOffset: CGPoint)
    {
        _scrollable.contentInset = contentInset
        _scrollable.contentOffset = contentOffset
    }

    public func emit(_ handler: @escaping (State) -> Void) {
        self.observer = handler
    }

    @objc private func handleGesture(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            isReachable = false
            _beginDrag = _scrollable.contentOffset.y
            _configurations.currentStatus = _previousState
        case .ended:
            /*
             * If the start and stop times are less than or equal to zero,
             * the movement is stopped.
             */
            if _beginDrag < 0,
               _scrollable.contentOffset.y < _configurations.lower
            {
                isReachable = true
            }
        case .possible, .changed, .cancelled, .failed:
            break
        @unknown default:
            break
        }
    }
}

// swiftlint:enable all
