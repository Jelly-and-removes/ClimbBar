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
    // MARK: Member variable

    @IBOutlet var collectionView: UICollectionView!
    private var climbBar: ClimbBar!

    var thirdOfTheScreen: CGFloat {
        view.frame.size.width / 3 - 2
    }

    var cellSize: CGSize {
        CGSize(width: thirdOfTheScreen, height: thirdOfTheScreen)
    }

    // MARK: lifecycle

    override func loadView() {
        super.loadView()

        let statusBarHeight = UIApplication.statusBarHeight
        let toHeaderBottom = statusBarHeight + (navigationController?.barHeight ?? 0.0)

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
}

// MARK: UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        100
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
        cellSize
    }
}
