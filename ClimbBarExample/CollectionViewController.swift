//
//  CollectionViewController.swift
//  ClimbBarExample
//
//  Created by Shichimitoucarashi on 2019/10/22.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import ClimbBar
import UIKit

final class CollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    private var climbBar: ClimbBar!

    // MARK: lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        title = "CollectionViewController"

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (navigationController?.navigationBar.frame.size.height)!

        let conf = Configuration(range: statusBarHeight ... toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: collectionView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.navigationController?.setAlpha(alpha: state.progress)
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

// MARK: UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as? CollectionCell
        else {
            return UICollectionViewCell()
        }
        cell.icon.image = #imageLiteral(resourceName: "smokin")
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize
    {
        let cellSize: CGFloat = view.frame.size.width / 3 - 2
        return CGSize(width: cellSize, height: cellSize)
    }
}
