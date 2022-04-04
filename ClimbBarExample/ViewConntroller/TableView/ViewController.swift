//
//  ViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import ClimbBar
import UIKit

final class ViewController: UIViewController {
    // MARK: Member variable

    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    private var climbBar: ClimbBar!

    // MARK: lifecycle

    ///
    override func loadView() {
        super.loadView()
        navigationController?.setNavigationBarHidden(true, animated: false)
        let statusBarHeight = UIApplication.statusBarHeight
        let toHeaderBottom = statusBarHeight + navigationBar.frame.height
        let configuration = Configuration(range: statusBarHeight ... toHeaderBottom)
        tableView.contentInsetAdjustmentBehavior = .never
        climbBar = ClimbBar(configurations: configuration,
                            scrollable: tableView)

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

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Index: \(indexPath.row)"
        return cell
    }
}
