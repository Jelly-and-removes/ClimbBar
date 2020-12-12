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
    private var climbBar: ClimbBar!

    // MARK: lifecycle

    override func loadView() {
        super.loadView()
        title = "ViewController"
        let statusBarHeight = UIApplication.statusBarHeight
        let toHeaderBottom = statusBarHeight + (navigationController?.barHeight ?? 0)
        let conf = Configuration(range: statusBarHeight ... toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: tableView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.navigationController?.setAlpha(alpha: CGFloat(state.progress))
            let navigtionFrame = CGRect(x: 0,
                                        y: state.originY,
                                        width: self.view.frame.size.width,
                                        height: 44)
            self.navigationController?.navigationBar.frame = navigtionFrame
        }
    }

    deinit {
        print(#function)
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
