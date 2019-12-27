//
//  ViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import ClimbBar

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    private var climbBar: ClimbBar!

    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ViewController"

        self.tableView.dataSource = self

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (self.navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.tableView,
                                 state: { [weak self] state in
                                    self?.navigationController!.setAlpha(alpha: CGFloat(state.alpha))
                                    let navigtionFrame = CGRect(x: 0,
                                                                y: state.originY,
                                                                width: (self?.view.frame.size.width)!,
                                                                height: 44)
                                    self?.navigationController?.navigationBar.frame = navigtionFrame
        })
    }
}

// MARK: UITableViewDataSource
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
