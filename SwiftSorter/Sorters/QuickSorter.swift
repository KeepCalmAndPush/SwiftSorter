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
        refreshInterval = 0.3
        
        algorithmName = "Быстрая сортировка"
    }
    
    override func sortArray(inout array: [Int])
    {
        quickSort(&array, left: 0, right: array.count - 1)
    }
    
    func quickSort(inout array: [Int], left: Int, right: Int)
    {
        var i = left, j = right;
        let pivotIndex = (left + right) / 2
        let pivot = array[pivotIndex];
        
        self.diagramView?.selectElementsAtIndices(Array(left...right))
        
        while (i <= j)
        {
            while (array[i] < pivot)
            {
                i++;
            }
            while (array[j] > pivot)
            {
                j--;
            }
            
            if (i <= j)
            {
                self.diagramView?.highlightComparisonSucceededForElementAtIndex(i, comparedToElementAtIndex:j)
                
                self.swapElementsAtIndices(index1: i, index2: j, inArray: &array)
                
                i++;
                j--;
            }
        };

        
        if (left < j)
        {
            quickSort(&array, left:left, right:j);
        }
        if (i < right)
        {
            quickSort(&array, left:i, right:right);
        }
    }
}
