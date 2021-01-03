//
//  ViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/8/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import ClimbBar
import UIKit

final class LongHeaderViewController: UIViewController {
    // MARK: Member variable

    @IBOutlet var tableView: UITableView!
    private var climbBar: ClimbBar!
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerTitle: UILabel!
    @IBOutlet var backButton: UIButton!
    
    // MARK: lifecycle

    override func loadView() {
        super.loadView()
        title = "ViewController"
        navigationController?.isNavigationBarHidden = true
        confgigure()
        let toHeaderBottom = CGFloat(300)
        let conf = Configuration(range: 0 ... toHeaderBottom)
        tableView.contentInsetAdjustmentBehavior = .never
        climbBar = ClimbBar(configurations: conf,
                            scrollable: tableView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.headerTitle.font = state.fontSize
            self.backButton.alpha = state.progress
            guard state.height > UIApplication.statusBarHeight + 44 else {
                return
            }
            let navigtionFrame = CGRect(x: 0,
                                        y: state.originY ,
                                        width: self.view.frame.size.width,
                                        height: toHeaderBottom)
            self.headerView.frame = navigtionFrame
        }
    }

    @IBAction func pushInBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func confgigure(){
        configureTitle()
        configureHeader()
    }

    private func configureTitle(){
        let width = CGFloat(view.frame.size.width - 30)
        let originY: CGFloat = 200 - (81)
        self.headerTitle.frame = CGRect(x: 5.0, y: originY, width: width, height: 300.0)
    }

    private func configureHeader(){
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: 300))
    }
}

// MARK: UITableViewDataSource

extension LongHeaderViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Index: \(indexPath.row)"
        return cell
    }
}

extension ClimbBar.State {
    var fontSize: UIFont {
        UIFont.systemFont(ofSize: max(51 * progress, 19))
    }
}
