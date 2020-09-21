//
//  RootViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private let items: [String] = ["TableView", "WebView", "CollectionView"]

    // MARK: lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: UITableViewDataSource

extension RootViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let firstViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController")
            firstViewController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(firstViewController!, animated: true)
        } else if indexPath.row == 1 {
            let firstViewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController")
            navigationController?.pushViewController(firstViewController!, animated: true)
        } else if indexPath.row == 2 {
            let secondViewController = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController")
            navigationController?.pushViewController(secondViewController!, animated: true)
        }
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
