//
//  ViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import ClimbBar

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var climbBar: ClimbBar!
    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
       
        let conf = Configuration(range: UIApplication.shared.statusBarFrame.height..<UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
        self.title = "ViewController"
        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.tableView,
                                 state: { (state) in
                                    self.navigationController!.setAlpha(alpha: CGFloat(state.alpha))
                                    self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                                            y: state.originY,
                                                                                            width: self.view.frame.size.width,
                                                                                            height: 44)
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Index: \(indexPath.row)"
        return cell
    }
}

extension ViewController: UIScrollViewDelegate{
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print ("ContentOffSet: \(scrollView.contentInset)")
    }    
}
