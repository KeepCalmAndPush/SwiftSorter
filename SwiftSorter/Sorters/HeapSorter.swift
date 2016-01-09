//
//  HeapSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 07.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class HeapSorter: Sorter
{
    override init()
    {
        super.init()
        refreshInterval = 0.2
        animationDuration = 0.2
        
        algorithmName = "Сортировка кучей (heap)"
    }
    
    override func sortArray(inout arrayToSort: [Int])
    {
        makeHeap(&arrayToSort)
        sortHeap(&arrayToSort)
    }
    
    //Строим бинарное дерево с самым большим элементом в корне
    func moveElementUpToTheRoot(currentElementIndex : Int, inout inArray arrayToSort:[Int], remainingLength : Int)
    {
        var elementToMoveUpIndex = currentElementIndex
        let currentElement : Int = arrayToSort[elementToMoveUpIndex]
        
        while elementToMoveUpIndex <= remainingLength / 2
        {
            let biggestChildElementIndex = biggestChildElementIndexForElementAtIndex(elementToMoveUpIndex,
                                                                                     inArray:arrayToSort,
                                                                             remainingLength:remainingLength)
            
            let biggestChildElement = arrayToSort[biggestChildElementIndex]
            
            if currentElement >= biggestChildElement
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(elementToMoveUpIndex, comparedToElementAtIndex:biggestChildElementIndex)
                break
            }

            self.diagramView?.highlightComparisonSucceededForElementAtIndex(elementToMoveUpIndex, comparedToElementAtIndex:biggestChildElementIndex)
            swapElementsAtIndices(index1: elementToMoveUpIndex, index2: biggestChildElementIndex, inArray: &arrayToSort)

            elementToMoveUpIndex = biggestChildElementIndex
        }
    }
    
    func biggestChildElementIndexForElementAtIndex(currentElementIndex : Int, inArray arrayToSort: [Int], remainingLength : Int) -> Int
    {
        self.diagramView?.selectElementAtIndex(currentElementIndex)
        
        let firstChildElementIndex = 2 * currentElementIndex
        let firstChildElement = arrayToSort[firstChildElementIndex]
        
        var secondChildElementIndex : Int?
        
        var biggestChildElementIndex = firstChildElementIndex
        
        if (firstChildElementIndex < remainingLength)
        {
            secondChildElementIndex = firstChildElementIndex + 1
            let secondChildElement = arrayToSort[secondChildElementIndex!]
            
            if secondChildElement > firstChildElement
            {
                biggestChildElementIndex = secondChildElementIndex!
            }
        }
        
        var elementIndicesToSelect = [currentElementIndex, firstChildElementIndex]
        
        if secondChildElementIndex != nil
        {
            elementIndicesToSelect.append(secondChildElementIndex!)
        }
        
        self.diagramView?.selectElementsAtIndices(elementIndicesToSelect)
        
        return biggestChildElementIndex
    }
    
    func makeHeap(inout arrayToSort: [Int])
    {
        let length = arrayToSort.count
        
        for currentElementIndex : Int in (length/2).stride(through: 0, by: -1)
        {
            moveElementUpToTheRoot(currentElementIndex, inArray: &arrayToSort,
                                                remainingLength: length-1)
        }
    }
    
    func sortHeap(inout arrayToSort: [Int])
    {
        let length = arrayToSort.count - 1
        
        for currentElementIndex : Int in length.stride(to: 0, by: -1)
        {
            self.diagramView?.highlightComparisonSucceededForElementAtIndex(0, comparedToElementAtIndex: currentElementIndex)
            swapElementsAtIndices(index1: 0, index2: currentElementIndex, inArray: &arrayToSort)

            moveElementUpToTheRoot(0, inArray:&arrayToSort,
                              remainingLength:currentElementIndex - 1)
        }
    }
}
