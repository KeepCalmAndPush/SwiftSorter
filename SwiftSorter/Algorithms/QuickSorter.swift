//
//  QuickSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 08.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class QuickSorter: Sorter
{
    override init()
    {
        super.init()
        refreshInterval = 0.2
        
        algorithmName = "Быстрая сортировка"
    }
    
    override func sortArray(inout array: [Int])
    {
        let arrayToSortRange = NSMakeRange(0, array.count)
        
        quickSort(&array, inRange: arrayToSortRange)
        
        print("result: \((array))")
    }
    
    func quickSort(inout array: [Int], inRange range: NSRange)
    {
        if range.length <= 1
        {
            print("sorting array with range \(NSStringFromRange(range)), els: \(array[range.location..<range.location+range.length]) -- return")
            return
        }
        
        let arrayMaxIndex = range.location + range.length - 1
        
        let baseElementIndex = range.location + (range.length - 1) / 2
        let baseElement = array[baseElementIndex]
        
        var leftElementIndex = range.location
        var rightElementIndex = arrayMaxIndex
        
        print("sorting array with range \(NSStringFromRange(range)), els: \(array[range.location..<range.location+range.length]) bei: \(baseElementIndex), be: \(baseElement)")
        
//        while lessThanBaseElementIndex <= greaterThanBaseElementIndex
//        {
//            let lessThanBaseElement = array[lessThanBaseElementIndex]
//            let greaterThanBaseElement = array[greaterThanBaseElementIndex]
//            
//            if lessThanBaseElement > baseElement &&
//                baseElement > greaterThanBaseElement
//            {
//                array[lessThanBaseElementIndex] = greaterThanBaseElement
//                array[greaterThanBaseElementIndex] = lessThanBaseElement
//            }
//            
//            lessThanBaseElementIndex++
//            greaterThanBaseElementIndex--
//        }
        
        while leftElementIndex <= rightElementIndex
        {
            var leftElement = array[leftElementIndex]
            var rightElement = array[rightElementIndex]
            
            while leftElement < baseElement
            {
                leftElementIndex++
                leftElement = array[leftElementIndex]
            }
            while rightElement > baseElement
            {
                rightElementIndex--
                rightElement = array[rightElementIndex]
            }
            
            if leftElementIndex <= rightElementIndex
            {
                array[leftElementIndex] = rightElement
                array[rightElementIndex] = leftElement
                
                leftElementIndex++
                rightElementIndex--
            }
        }
        
//        while lessThanBaseElementIndex <= greaterThanBaseElementIndex
//        {
//            let lessThanBaseElement = array[lessThanBaseElementIndex]
//
//            if lessThanBaseElement >= baseElement
//            {
//                while lessThanBaseElementIndex <= greaterThanBaseElementIndex
//                {
//                    let greaterThanBaseElement = array[greaterThanBaseElementIndex]
//                    
//                    if greaterThanBaseElement <= baseElement
//                    {
//                        self.diagramView?.highlightComparisonSucceededForElementAtIndex(lessThanBaseElementIndex, comparedToElementAtIndex: greaterThanBaseElementIndex)
//                        
//                        swapElementsAtIndices(index1: lessThanBaseElementIndex, index2: greaterThanBaseElementIndex, inArray: &array)
//                        
//                        greaterThanBaseElementIndex--
//                        
//                        break
//                    }
//                    else
//                    {
//                        self.diagramView?.highlightComparisonFailedForElementAtIndex(lessThanBaseElementIndex, comparedToElementAtIndex: greaterThanBaseElementIndex)
//                    }
//                    
//                    greaterThanBaseElementIndex--
//                }
//            }
//            else
//            {
//                self.diagramView?.highlightComparisonFailedForElementAtIndex(lessThanBaseElementIndex, comparedToElementAtIndex: greaterThanBaseElementIndex)
//            }
//            
//            lessThanBaseElementIndex++
//        }
        
        print("result: \((array[range.location..<range.location+range.length]))")
        
        let leftArrayRange = leftArrayRangeForRange(range, baseElementIndex: baseElementIndex)
        let rightArrayRange = rightArrayRangeForRange(range, baseElementIndex: baseElementIndex)
        
        quickSort(&array, inRange: leftArrayRange)
        quickSort(&array, inRange: rightArrayRange)
    }
    
    func leftArrayRangeForRange(range : NSRange, baseElementIndex : Int)  -> NSRange
    {
        let lessThanBaseArrayRange : NSRange
        let lessThanBaseArrayLength = baseElementIndex - range.location + 1
        lessThanBaseArrayRange = NSMakeRange(range.location, lessThanBaseArrayLength)
        
        return lessThanBaseArrayRange
    }
    
    func rightArrayRangeForRange(range : NSRange, baseElementIndex : Int) -> NSRange
    {
        let greaterThanBaseArrayRange : NSRange
        let greaterThanBaseArrayLocation = baseElementIndex + 1
        let greaterThanBaseArrayLength = range.location + range.length - greaterThanBaseArrayLocation
        
        greaterThanBaseArrayRange = NSMakeRange(baseElementIndex + 1, greaterThanBaseArrayLength)
        
        return greaterThanBaseArrayRange
    }

}
