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
    override init()
    {
        super.init()
        refreshInterval = 0.2
        
        algorithmName = "Выбором"
    }
    
    override func sortArray(arrayToSort: [Int])
    {
        for currentElementIndex in 0..<arrayToSort.count
        {
            let remainingRangeLength = arrayToSort.count - currentElementIndex
            
            let remainingRange = NSRange(location: currentElementIndex,
                length: remainingRangeLength)
            
            let currentMinElementIndex = minElementIndexInRangeOfArray(remainingRange, array: arrayToSort)

            if stopped
            {
                break
            }
            
            swapElementsAtIndices(index1:currentElementIndex,
                                  index2:currentMinElementIndex!,
                                 inArray:arrayToSort)
        }
        
        self.diagramView?.clearSelection()
    }
    
    func minElementIndexInRangeOfArray(range: NSRange, array arrayToSort: [Int]) -> Int?
    {
        var minElementIndex = range.location
        var minElement : Int = arrayToSort[minElementIndex]
        
        for index in range.location ..< range.location + range.length
        {
            let currentElement = arrayToSort[index]
            
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
