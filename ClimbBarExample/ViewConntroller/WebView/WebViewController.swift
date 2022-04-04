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
    @IBOutlet var navigationBar: UINavigationBar!
    private var climbBar: ClimbBar!

    // MARK: lifecycle

    override func loadView() {
        super.loadView()

        webView.scrollView.contentInsetAdjustmentBehavior = .never
        navigationController?.setNavigationBarHidden(true, animated: false)
        webView.load(URLRequest(url: URL(string: "https://github.com")!))
        let statusBarHeight = UIApplication.statusBarHeight
        let toHeaderBottom = statusBarHeight + (navigationController?.barHeight ?? 0)
        let configuration = Configuration(range: statusBarHeight ... toHeaderBottom)

        climbBar = ClimbBar(configurations: configuration,
                            scrollable: webView.scrollView)

        climbBar.emit { [weak self] state in
            guard let self = self else { return }
            self.navigationBar.setAlpha(CGFloat(state.progress))
            let navigationFrame = CGRect(x: 0,
                                         y: state.originY,
                                         width: self.view.frame.size.width,
                                         height: 44)
            self.navigationBar.frame = navigationFrame
        }
    }

    @IBAction func pushBarButtonItem(_: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
