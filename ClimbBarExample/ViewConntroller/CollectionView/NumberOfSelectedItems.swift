//
//  NumberOfSelectedItems.swift
//  ClimbBarExample
//
//  Created by keisuke yamagishi on 2024/06/20.
//  Copyright © 2024 Shichimitoucarashi. All rights reserved.
//

import Foundation

class NumberOfSelectedItems {

    struct Item {
        let index: IndexPath
        var count: Int
    }

    var selectedOfNumber = 0
    var selectedCells: [IndexPath] = []
    var selectedItems: [Item] = []

    func isSelectedItem(indexPath: IndexPath) -> Bool {
        selectedCells.contains(indexPath)
    }

    func didSelectedItem(indexPath: IndexPath) {
        if !selectedCells.contains(indexPath),
           selectedCells.count < 4
        {
            selectedCells.append(indexPath)
            selectedItems.append(Item(index: indexPath,
                                      count: selectedOfNumber))
            selectedOfNumber += 1
        } else {
            if let index = getIndex(indexPath: indexPath) {
                selectedCells.remove(at: index)
                selectedItems.remove(at: index)
                
                selectedItems.sort {
                    $0.count < $1.count
                }
                
                var count = 0
                var items: [Item] = []
                selectedItems.forEach {
                    items.append(Item(index: $0.index, count: count))
                    count += 1
                }
                
                selectedItems = items
                
                selectedOfNumber -= 1
                
            } else {
                
            }
        }
    }

    func getItem(_ indexPath: IndexPath) -> String? {
        for index in 0 ..< selectedItems.count {
            let selectedItem = selectedItems[index]
            if selectedItem.index == indexPath {
                return "\(selectedItem.count)"
            }
        }
        return nil
    }

    private func getIndex(indexPath: IndexPath) -> Int? {
        for index in 0 ..< selectedCells.count {
            let selectedIndexPath = selectedCells[index]
            if selectedIndexPath == indexPath {
                return index
            }
        }
        return nil
    }
}
