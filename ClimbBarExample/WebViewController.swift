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
        
        self.title = "WebViewController"
        
        self.webView.load(URLRequest(url: URL(string: "https://github.com")!))
        self.webView.scrollView.contentInsetAdjustmentBehavior = .never
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (self.navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)
        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.webView.scrollView,
                                 state: { [weak self] (state) in
                                    self?.navigationController?.setAlpha(alpha: state.alpha)
                                    let navigtionFrame = CGRect(x: 0,
                                                                y: state.originY,
                                                                width: (self?.view.frame.size.width)!,
                                                                height: 44)
                                    self?.navigationController?.navigationBar.frame = navigtionFrame
        })        
    }
}
