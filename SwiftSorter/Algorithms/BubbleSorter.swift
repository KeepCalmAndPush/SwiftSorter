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
    
    override func sort()
    {
        var surfaceElementIndex = 0
        
        while surfaceElementIndex != self.array!.count - 1
        {
            floatLightestElementUpToSurface(surfaceElementIndex)
            
            if let lastIndex = lastPermutationIndex
            {
                surfaceElementIndex = max(lastIndex, surfaceElementIndex + 1)
            }
            else
            {
                break
            }
        }
        
        self.diagramView?.clearSelection()
    }
    
    func floatLightestElementUpToSurface(surfaceElementIndex : Int)
    {
        let floatingStartElement : Int = (self.array?.count)! - 1
        
        for elementIndex in floatingStartElement.stride(to: surfaceElementIndex, by: -1)
        {
            let element = self.array?[elementIndex]
            let elementAbove = self.array![elementIndex - 1]
            
            if element < elementAbove
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(elementIndex, comparedToElementAtIndex: elementIndex - 1)
                swapElementsAtIndices(index1: elementIndex - 1, index2: elementIndex)
                
                lastPermutationIndex = elementIndex
            }
            else
            {
                self.diagramView?.highlightComparisonFailedForElementAtIndex(elementIndex, comparedToElementAtIndex: elementIndex - 1)
            }
        }
    }
}
