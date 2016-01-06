//
//  GnomeSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 06.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class GnomeSorter: Sorter
{
    override init()
    {
        super.init()
        refreshInterval = 0.2
        
        algorithmName = "Гномья сортировка"
    }
    
    override func sortArray(arrayToSort: [Int])
    {
        var currentElementIndex = 0
        
        while currentElementIndex < arrayToSort.count
        {
            if (currentElementIndex == 0)
            {
                currentElementIndex++
            }
            
            let previousElementIndex = currentElementIndex - 1
            
            let currentElement = arrayToSort[currentElementIndex]
            let previousElement = arrayToSort[previousElementIndex]
            
            if(currentElement < previousElement)
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(currentElementIndex, comparedToElementAtIndex: previousElementIndex)
                
                swapElementsAtIndices(index1: currentElementIndex, index2: previousElementIndex,
                    inArray:arrayToSort)
                
                currentElementIndex = previousElementIndex
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(currentElementIndex, comparedToElementAtIndex: previousElementIndex)
                
                currentElementIndex++
            }
        }
        
        self.diagramView?.clearSelection()
    }
}
