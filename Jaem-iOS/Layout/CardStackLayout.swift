//
//  CardStackLayout.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 21..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct CardStackLayoutConstant {
    struct Cell {
        let visibleCellHeight : CGFloat = 50
        let actualCellHeight :CGFloat = 200
    }
}

class CardStackLayout: UICollectionViewLayout {
    
    
    override func collectionViewContentSize() -> CGSize {
        return (collectionView?.bounds.size)!
    }
    
   
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        let visibleIndexPaths = indexPathsOfItemsInRect(rect)
        
        for indexPath in visibleIndexPaths {
            let attribute = layoutAttributesForItemAtIndexPath(indexPath)
            attribute?.zIndex = indexPath.row
            attributes.append(attribute!)
            
        }
        
        return attributes
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = computedFrame(indexPath, offset: attributes.indexPath.row, height:CardStackLayoutConstant.Cell().actualCellHeight)
        
        return attributes
    }
    
    func computedFrame(indexPath: NSIndexPath, offset: Int, height: CGFloat) ->  CGRect {
        return CGRect(x: 0.0, y: CardStackLayoutConstant.Cell().visibleCellHeight * CGFloat(offset) + 10, width: CGFloat(self.collectionView!.bounds.width), height: height)
    }
    
    func indexPathsOfItemsInRect(rect: CGRect) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        var sectionsCount = 0
        if let sections = self.collectionView?.numberOfSections() {
            sectionsCount = sections
        }
        
        for section in 0..<sectionsCount {
            var rowsCount = 0
            if let rows = self.collectionView?.numberOfItemsInSection(section) {
                rowsCount = rows
            }
            
            for row in 0..<rowsCount {
                indexPaths.append(NSIndexPath(forRow: row, inSection: section))
            }
        }
        
        return indexPaths
    }
    
    
}
