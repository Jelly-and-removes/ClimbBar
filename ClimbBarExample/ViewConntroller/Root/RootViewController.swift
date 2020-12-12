//
//  RootViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    // MARK: Member variable

    @IBOutlet var tableView: UITableView!
    private let items: [String] = ["TableView", "WebView", "CollectionView"]

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        title = "RootViewController"
    }
}

// MARK: UITableViewDataSource

extension RootViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "TableView", bundle: nil)
            let firstViewController = storyboard.instantiateInitialViewController()
            firstViewController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(firstViewController!, animated: true)
        } else if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "WebView", bundle: nil)
            let firstViewController = storyboard.instantiateInitialViewController()
            navigationController?.pushViewController(firstViewController!, animated: true)
        } else if indexPath.row == 2 {
            let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
            let secondViewController = storyboard.instantiateInitialViewController()
            navigationController?.pushViewController(secondViewController!, animated: true)
        }
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
