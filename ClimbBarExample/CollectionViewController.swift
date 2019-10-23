//
//  CollectionViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 2019/10/22.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import ClimbBar

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var climbBar: ClimbBar? = nil
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.title = "CollectionViewController"
        self.collectionView.contentInsetAdjustmentBehavior = .never
        let conf = Configuration(range: UIApplication.shared.statusBarFrame.height..<UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.collectionView,
                                 state: { (state) in
                                    self.navigationController?.setAlpha(alpha: state.alpha)
                                    self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                                            y: state.originY,
                                                                                            width: self.view.frame.size.width,
                                                                                            height: 44)
        })
        
    }
}

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

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = self.view.frame.size.width/3 - 2
        return CGSize(width: cellSize, height: cellSize)
    }
}

