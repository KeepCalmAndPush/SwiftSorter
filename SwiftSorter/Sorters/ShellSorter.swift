//
//  ShellSorter.swift
//  SwiftSorter
//
//  Created by Андрей on 06.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class ShellSorter: InsertionSorter
{
    override init()
    {
        super.init()
        refreshInterval = 0.2
        suitableElementsCount = 25
        
        algorithmName = "Сортировка Шелла"
    }
    
    override func sortArray(inout arrayToSort: [Int])
    {
        var distance = arrayToSort.count / 2
        
        while distance > 0
        {
            let indexSets = indexSetsForDistance(distance, inArray:arrayToSort)
            
            for indexSet in indexSets
            {
                super.sortArrayInIndexSet(&arrayToSort, set:indexSet)
            }
            
            distance /= 2
        }
    }
    
    
    func indexSetsForDistance(distance : Int, inArray array:[Int]) -> [NSIndexSet]
    {
        var indexSetsForDistance = [NSIndexSet]()
        
        for startingElementIndex in 0..<distance
        {
            let indexSet = NSMutableIndexSet()
            
            var elementIndex = startingElementIndex
            
            while elementIndex  < array.count
            {
                indexSet.addIndex(elementIndex)
                
                elementIndex += distance
            }
            
            indexSetsForDistance.append(indexSet)
        }
        
        return indexSetsForDistance
    }
}
