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
        title = "ViewController"

        tableView.dataSource = self

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: tableView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.navigationController?.setAlpha(alpha: CGFloat(state.alpha))
            let navigtionFrame = CGRect(x: 0,
                                        y: state.originY,
                                        width: self.view.frame.size.width,
                                        height: 44)
            self.navigationController?.navigationBar.frame = navigtionFrame
        }
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
