//
//  CollectionViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 2019/10/22.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import ClimbBar

final class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var climbBar: ClimbBar!

    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.title = "CollectionViewController"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (self.navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)
        collectionView.contentInsetAdjustmentBehavior = .never
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.collectionView,
                                 state: { [weak self] state in
                                    print("state originY \(state.originY)\nstate distance \(state.distance)\nstate height \(state.height)\nstate alpha \(state.alpha)")
                                    guard let self = self else { return }
                                    self.navigationController?.setAlpha(alpha: state.alpha)
                                    let navigtionFrame = CGRect(x: 0,
                                                                y: state.originY,
                                                                width: self.view.frame.size.width,
                                                                height: 44)
                                    self.navigationController?.navigationBar.frame = navigtionFrame
        })        
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
        cell.icon.image = #imageLiteral(resourceName: "smokin")
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = self.view.frame.size.width/3 - 2
        return CGSize(width: cellSize, height: cellSize)
    }
}
