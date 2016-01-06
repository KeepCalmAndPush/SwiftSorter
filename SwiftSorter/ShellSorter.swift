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
        
        algorithmName = "Сортировка Шелла"
    }
    
    override func sortArray(inout arrayToSort: [Int])
    {
        var distance = arrayToSort.count / 2
        
        while distance > 0
        {
            let subarrays = subarraysForDistance(distance, inArray: arrayToSort)
            
            for var subarray : [Int] in subarrays
            {
                super.sortArray(&subarray)
            }
            
            distance = distance / 2
        }
    }
    
    
    func subarraysForDistance(distance : Int, inArray array:[Int]) -> [[Int]]
    {
        var arraysForDistance = [[Int]]()
        
        for startingElementIndex in 0..<distance
        {
            var array = [Int]()
            
            var elementIndex = startingElementIndex
            
            while elementIndex < array.count
            {
                array.append(array[elementIndex])
                
                elementIndex += distance
            }
            
            arraysForDistance.append(array)
        }
        
        return arraysForDistance
    }
}
