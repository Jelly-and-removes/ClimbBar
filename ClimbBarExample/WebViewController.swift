//
//  WebViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import WebKit
import ClimbBar

final class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    private var climbBar: ClimbBar!

    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "WebViewController"

        webView.load(URLRequest(url: URL(string: "https://github.com")!))

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: webView.scrollView)

        climbBar.observer = { [weak self] (state) in
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
