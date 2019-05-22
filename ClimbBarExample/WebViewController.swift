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

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var climbBar:ClimbBar! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "WebViewController"
        
        webView.load(URLRequest(url: URL(string: "https://github.com")!))
        
        let conf = Configuration(range: UIApplication.shared.statusBarFrame.height..<UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.webView.scrollView,
                                 state: { (state) in
                                    self.navigationController?.setAlpha(alpha: state.alpha)
                                    self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                                            y: state.originY,
                                                                                            width: self.view.frame.size.width,
                                                                                            height: 44)
        })        
    }
}
