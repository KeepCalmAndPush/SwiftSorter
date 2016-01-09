//
//  MergeSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 09.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class MergeSorter: Sorter
{
    override init()
    {
        super.init()
        refreshInterval = 0.3
        suitableElementsCount = 30
        
        algorithmName = "Сортировка слиянием"
    }
    
    override func sortArray(inout arrayToSort: [Int])
    {
        mergeSort(&arrayToSort, leftBound: 0, rightBound: arrayToSort.count)
    }
    
    func mergeSort(inout array : [Int], leftBound: Int, rightBound: Int)
    {
        if(leftBound < rightBound - 1)
        {
            let split = (leftBound + rightBound) / 2
            
            self.diagramView?.selectElementsAtIndices(Array(leftBound..<rightBound))
            
            mergeSort(&array, leftBound: leftBound, rightBound: split)
            mergeSort(&array, leftBound: split, rightBound: rightBound)
            
            merge(&array, leftBound: leftBound, split: split, rightBound: rightBound)
        }
    }
    
    func merge(inout array:[Int], leftBound:Int, split:Int, rightBound:Int)
    {
        self.diagramView?.selectElementsAtIndices(Array(leftBound..<rightBound))
        
        var buffer = [Int]()
        
        var leftArrayIndex = leftBound
        var rightArrayIndex = split

        var minElement : Int
        
        while leftArrayIndex < split && rightArrayIndex < rightBound
        {
            let leftArrayElement = array[leftArrayIndex]
            let rightArrayElement = array[rightArrayIndex]
            
            if leftArrayElement < rightArrayElement
            {
                minElement = leftArrayElement
                leftArrayIndex++
            }
            else
            {
                minElement = rightArrayElement
                rightArrayIndex++
            }
            
            buffer.append(minElement)
        }
        
        for lindex in leftArrayIndex..<split
        {
            buffer.append(array[lindex])
        }
        
        for rindex in rightArrayIndex..<rightBound
        {
            buffer.append(array[rindex])
        }
        
        for index in 0..<buffer.count
        {
            let sourceElement = array[index + leftBound]
            let targetElement = buffer[index]
            
            if sourceElement != targetElement
            {
                let sourceElementIndex = array.indexOf(sourceElement)!
                let targetElementIndex = array.indexOf(targetElement)!
                
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(sourceElementIndex, comparedToElementAtIndex: targetElementIndex)
                
                self.swapElementsAtIndices(index1: sourceElementIndex, index2: targetElementIndex, inArray: &array)
            }
        }
    }
}
