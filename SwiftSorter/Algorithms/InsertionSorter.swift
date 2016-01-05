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
        refreshInterval = 0.3
        
        algorithmName = "Простыми вставками"
    }
    
    override func sort()
    {
        for currentElementIndex in 0..<self.array!.count
        {
            self.diagramView?.selectElementAtIndex(currentElementIndex)
            moveToSortedPartElementWithIndex(currentElementIndex)
        }
        
        self.diagramView?.clearSelection()
    }

    func moveToSortedPartElementWithIndex(elementToMoveIndex : Int)
    {
        var previousElementIndex = elementToMoveIndex - 1
        
        while previousElementIndex >= 0
        {
            let elementToMove = self.array![previousElementIndex + 1]
            let previousElement = self.array![previousElementIndex]
            
            if previousElement > elementToMove
            {
                swapElementsAtIndices(index1: previousElementIndex, index2: previousElementIndex + 1)
                
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(previousElementIndex + 1,
                    comparedToElementAtIndex: previousElementIndex)
                
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
