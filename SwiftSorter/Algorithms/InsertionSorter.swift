//
//  InsertionSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class InsertionSorter: Sorter
{
    
    override init()
    {
        super.init()
        refreshInterval = 0.15
        
        algorithmName = "Простыми вставками"
    }
    
    override func sortArray(arrayToSort: [Int])
    {
        for currentElementIndex in 0..<arrayToSort.count
        {
            self.diagramView?.selectElementAtIndex(currentElementIndex)
            moveToSortedPartElementWithIndex(currentElementIndex, inArray: arrayToSort)
            
            if(stopped)
            {
                break
            }
        }
        
        self.diagramView?.clearSelection()
    }

    func moveToSortedPartElementWithIndex(elementToMoveIndex : Int, inArray arrayToSort:[Int])
    {
        var previousElementIndex = elementToMoveIndex - 1
        
        while previousElementIndex >= 0
        {
            if(stopped)
            {
                return
            }
            
            let elementToMove = arrayToSort[previousElementIndex + 1]
            let previousElement = arrayToSort[previousElementIndex]
            
            if previousElement > elementToMove
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(previousElementIndex + 1,
                    comparedToElementAtIndex: previousElementIndex)
                
                swapElementsAtIndices(index1: previousElementIndex, index2: previousElementIndex + 1,
                    inArray:arrayToSort)

                previousElementIndex--;
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(previousElementIndex + 1, comparedToElementAtIndex:previousElementIndex)
                break
            }
        }
    }
}
