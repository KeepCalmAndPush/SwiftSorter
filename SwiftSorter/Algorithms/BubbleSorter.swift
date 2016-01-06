//
//  BubbleSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class BubbleSorter: Sorter
{
    private var lastPermutationIndex : Int? //Оптимизация для частично отсортированных массивов. Проходим не весь остаток массива, а только до индекса последней перестановки
    
    override init()
    {
        super.init()
        refreshInterval = 0.2
        
        algorithmName = "Пузырьком"
    }
    
    override func sortArray(arrayToSort: [Int])
    {
        var surfaceElementIndex = 0
        
        while surfaceElementIndex != arrayToSort.count - 1
        {
            floatLightestElementUpToSurface(surfaceElementIndex, inArray: arrayToSort)
            
            if(stopped)
            {
                break
            }
            
            if let lastIndex = lastPermutationIndex
            {
                surfaceElementIndex = max(lastIndex, surfaceElementIndex + 1)
                lastPermutationIndex = nil
            }
            else
            {
                break
            }
        }
        
        self.diagramView?.clearSelection()
    }
    
    func floatLightestElementUpToSurface(surfaceElementIndex : Int, inArray arrayToSort:[Int])
    {
        let floatingStartElement : Int = (self.array?.count)! - 1
        
        for elementIndex in floatingStartElement.stride(to: surfaceElementIndex, by: -1)
        {
            if(stopped)
            {
                return
            }
            
            let element = self.array?[elementIndex]
            let elementAbove = arrayToSort[elementIndex - 1]
            
            if element < elementAbove
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(elementIndex, comparedToElementAtIndex: elementIndex - 1)
                swapElementsAtIndices(index1: elementIndex - 1, index2: elementIndex,
                    inArray:arrayToSort)
                
                lastPermutationIndex = elementIndex
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(elementIndex, comparedToElementAtIndex: elementIndex - 1)
            }
        }
    }
}
