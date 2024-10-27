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

    @IBOutlet var header: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var navigationBar: UINavigationBar!
    private var climbBar: ClimbBar!
    private var selectedCount: NumberOfSelectedItems = NumberOfSelectedItems()

    var thirdOfTheScreen: CGFloat {
        view.frame.size.width / 3 - 2
    }

    var cellSize: CGSize {
        CGSize(width: thirdOfTheScreen, height: thirdOfTheScreen)
    }

    // MARK: lifecycle

    override func loadView() {
        super.loadView()

        navigationBar.frame = CGRect(x: 0,
                                     y: 0,
                                     width: view.bounds.width,
                                     height: 44)
        collectionView.contentInsetAdjustmentBehavior = .never
        navigationController?.setNavigationBarHidden(true, animated: false)
        let statusBarHeight = UIApplication.statusBarHeight

        header.frame = CGRect(x: 0,
                              y: 0,
                              width: view.bounds.width,
                              height: statusBarHeight)

        let toHeaderBottom = statusBarHeight + (navigationController?.barHeight ?? 0.0)
        let configuration = Configuration(range: statusBarHeight ... toHeaderBottom)

        climbBar = ClimbBar(configurations: configuration,
                            scrollable: collectionView)

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

        cell.countLabel.clipsToBounds = true
        cell.countLabel.layer.cornerRadius = 10

        if selectedCount.isSelectedItem(indexPath: indexPath) {
            cell.countLabel.isHidden = false
            cell.countLabel.text = selectedCount.getItem(indexPath)
        } else {
            cell.countLabel.isHidden = true
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

// MARK: UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCount.didSelectedItem(indexPath: indexPath)
        collectionView.reloadData()
    }
}
