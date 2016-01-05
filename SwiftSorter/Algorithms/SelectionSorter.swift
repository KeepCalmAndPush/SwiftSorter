//
//  SelectionSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 04.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class SelectionSorter: Sorter
{
    override func sort()
    {
        for currentElementIndex in 0..<self.array!.count
        {
            let remainingRangeLength = self.array!.count - currentElementIndex
            
            let remainingRange = NSRange(location: currentElementIndex,
                length: remainingRangeLength)
            
            let currentMinElementIndex = minElementIndexInRange(remainingRange)
            
            if stopped
            {
                return
            }
            
            swapElementsAtIndices(index1:currentElementIndex,
                                  index2:currentMinElementIndex!)
        }
        
        self.diagramView?.clearSelection()
    }
    
    func minElementIndexInRange(range: NSRange) -> Int?
    {
        var minElementIndex = range.location
        var minElement : Int = self.array![minElementIndex]
        
        for index in range.location ..< range.location + range.length
        {
            let currentElement = self.array![index]
            
            if currentElement < minElement
            {
                minElement = currentElement
                minElementIndex =  index
            }
            
            self.diagramView?.highlightComparisonSucceededForElementAtIndex(index, comparedToElementAtIndex: minElementIndex)
            
            if stopped
            {
                return nil
            }
        }
        
        return minElementIndex
    }
}
