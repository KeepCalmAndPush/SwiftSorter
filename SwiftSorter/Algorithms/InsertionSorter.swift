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
    
    override func sortArray(inout arrayToSort: [Int])
    {
        let set : NSIndexSet = NSIndexSet(indexesInRange: NSMakeRange(0, arrayToSort.count))
        
        sortArrayInIndexSet(&arrayToSort, set: set)
    }
    
    func sortArrayInIndexSet(inout arrayToSort: [Int], set:NSIndexSet)
    {
        for currentElementIndex in set
        {
            moveToSortedPartElementWithIndex(currentElementIndex, indexSet:set, inArray: &arrayToSort)
            
            if array == nil
            {
                break
            }
        }
    }

    func moveToSortedPartElementWithIndex(elementToMoveIndex : Int, indexSet : NSIndexSet, inout inArray arrayToSort:[Int])
    {
        var previousElementIndex = indexSet.indexLessThanIndex(elementToMoveIndex)
        
        while previousElementIndex != NSNotFound
        {
            if array == nil
            {
                return
            }
            
            let currentElementIndex = indexSet.indexGreaterThanIndex(previousElementIndex)
            
            let elementToMove = arrayToSort[currentElementIndex]
            let previousElement = arrayToSort[previousElementIndex]
            
            if previousElement > elementToMove
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(currentElementIndex,
                                                      comparedToElementAtIndex: previousElementIndex)
                
                swapElementsAtIndices(index1: previousElementIndex,
                                      index2: currentElementIndex,
                                     inArray: &arrayToSort)

                previousElementIndex = indexSet.indexLessThanIndex(previousElementIndex)
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(currentElementIndex, comparedToElementAtIndex:previousElementIndex)
                break
            }
        }
    }
}
