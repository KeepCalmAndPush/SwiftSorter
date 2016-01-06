//
//  BubbleSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class ShakerSorter: Sorter
{
    private var lastPermutationIndex : Int? //Оптимизация для частично отсортированных массивов. Проходим не весь остаток массива, а только до индекса последней перестановки
    
    private var surfaceBoundIndex : Int?
    private var bottomBoundIndex : Int?
    
    override init()
    {
        super.init()
        refreshInterval = 0.1
        
        algorithmName = "Шейкер-сортировка"
    }
    
    override func sortArray(arrayToSort: [Int])
    {
        surfaceBoundIndex = 0
        bottomBoundIndex = arrayToSort.count - 1
        
        repeat
        {
            floatLightestElementUpToSurface(surfaceBoundIndex!, inArray: arrayToSort)
            
            if lastPermutationIndex == nil
            {
                break
            }
            else
            {
                surfaceBoundIndex = lastPermutationIndex!
                lastPermutationIndex = nil
            }

            drownHeaviestElementDownToBottom(bottomBoundIndex!, inArray: arrayToSort)
            
            if lastPermutationIndex == nil
            {
                break
            }
            else
            {
                bottomBoundIndex = lastPermutationIndex! - 1
                lastPermutationIndex = nil
            }
        }
        while bottomBoundIndex > surfaceBoundIndex
        
        self.diagramView?.clearSelection()
    }
    
    func floatLightestElementUpToSurface(surfaceElementIndex : Int, inArray arrayToSort:[Int])
    {
        let floatingStartElement : Int = arrayToSort.count - 1
        
        for elementIndex in floatingStartElement.stride(to: surfaceElementIndex, by: -1)
        {
            if(stopped)
            {
                return
            }
            
            let element = arrayToSort[elementIndex]
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
    
    func drownHeaviestElementDownToBottom(bottomElementIndex : Int, inArray arrayToSort:[Int])
    {
        for elementIndex in 1...bottomElementIndex
        {
            if(stopped)
            {
                return
            }
            
            let element = arrayToSort[elementIndex-1]
            let elementBelow = arrayToSort[elementIndex]
            
            if element > elementBelow
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(elementIndex-1, comparedToElementAtIndex: elementIndex)
                swapElementsAtIndices(index1: elementIndex - 1, index2: elementIndex,
                    inArray:arrayToSort)
                
                lastPermutationIndex = elementIndex
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(elementIndex - 1, comparedToElementAtIndex: elementIndex)
            }
        }
    }
}
