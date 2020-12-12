//
//  WebViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import ClimbBar
import UIKit
import WebKit

final class WebViewController: UIViewController {
    // MARK: Member variable

    @IBOutlet var webView: WKWebView!
    private var climbBar: ClimbBar!

    // MARK: lifecycle

    override func loadView() {
        super.loadView()

        webView.load(URLRequest(url: URL(string: "https://github.com")!))
        webView.scrollView.scrollsToTop = false
        let statusBarHeight = UIApplication.statusBarHeight
        let toHeaderBottom = statusBarHeight + (navigationController?.barHeight ?? 0)
        let conf = Configuration(range: statusBarHeight ... toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: webView.scrollView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.navigationController?.setAlpha(alpha: state.progress)
            let navigtionFrame = CGRect(x: 0,
                                        y: state.originY,
                                        width: self.view.frame.size.width,
                                        height: 44)
            self.navigationController?.navigationBar.frame = navigtionFrame
        }
    }
}
