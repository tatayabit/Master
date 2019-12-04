//
//  HomeHorizontalLayout.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeHorizontalLayout: UICollectionViewLayout {
    //MARK:- Properties

    fileprivate var numberOfRows = 2
    fileprivate var numberOfColumns = 4

    fileprivate var cellPadding: CGFloat = 3

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentWidth: CGFloat = 0

    fileprivate var superWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return (collectionView.bounds.width - (insets.left + insets.right))
    }


    override var collectionViewContentSize: CGSize {
//        print("collectionViewContentSize: width: \(contentWidth), height: \(superWidth)")
        return CGSize(width: contentWidth, height: 220)
    }

    //MARK:- UICollectionViewLayout Delegate

    override func prepare() {
        // 1
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        calculateSizes(collectionView)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }


    //MARK:- Size calculations
    fileprivate func calculateSizes(_ collectionView: UICollectionView) {
        // 2
        let columnWidth = superWidth / CGFloat(numberOfColumns) - 8

        var yOffset = [CGFloat]()

        for row in 0 ..< numberOfRows {
            yOffset.append(CGFloat(row) * 101.5)
        }

        var row = 0
        var column = 0

        var xOffset = [CGFloat](repeating: 0, count: numberOfRows)


        // 3
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            if item == 0 {
                let result = updateFirstItem(columnWidth: columnWidth, x: xOffset[column], y: yOffset[row], xOffsetColumn: xOffset[column])


                for columnxx in 0 ..< xOffset.count {
                    xOffset[columnxx] = result.0
                }
                //        row = result.1
                //        column = result.2
                continue
            }
            let indexPath = IndexPath(item: item, section: 0)

            // 4
            let height = cellPadding * 2 + columnWidth
            let frame = CGRect(x: xOffset[column], y: yOffset[row], width: height, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            print("insetFrame: \(insetFrame)")

            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)


            // 6
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[column] = xOffset[column] + height

            row = row < (numberOfRows - 1) ? (row + 1) : 0
            column = column < (numberOfRows - 1) ? (column + 1) : 0

        }

    }

    func updateFirstItem(columnWidth: CGFloat, x: CGFloat, y: CGFloat, xOffsetColumn:CGFloat) -> (CGFloat, Int, Int) {
        // 4
        let height = cellPadding * 2 + (columnWidth * 2) + 10
        let frame = CGRect(x: x, y: y, width: height, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)


        let indexPath = IndexPath(item: 0, section: 0)

        // 5
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)


        // 6
        contentWidth = max(contentWidth, frame.maxX)
        let xOffset = xOffsetColumn + height

        let row = 0 < (numberOfRows - 1) ? (0 + 1) : 0
        let column = 0 < (numberOfRows - 1) ? (0 + 1) : 0

        return (xOffset, row, column)
    }

}
