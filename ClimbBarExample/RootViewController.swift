//
//  RootViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 5/22/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items: [String] = ["TableView", "WebView","CollectionView"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
            firstViewController?.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(firstViewController!, animated: true)
            
        } else if indexPath.row == 1 {
            let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")
            
            self.navigationController?.pushViewController(firstViewController!, animated: true)
        }else if indexPath.row == 2 {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController")
            self.navigationController?.pushViewController(secondViewController!, animated: true)
        }
    }
}

extension RootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
}
