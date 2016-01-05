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
    override func sort()
    {
        for surfaceElementIndex in 0..<self.array!.count
        {
            self.diagramView?.selectElementAtIndex(surfaceElementIndex)
            
        }
        
        self.diagramView?.clearSelection()
    }
    
    func floatLightestElementUpToSurface(surfaceElementIndex : Int)
    {
        let floatingStartElement : Int = (self.array?.count)!
        
        for elementIndex in floatingStartElement.stride(to: surfaceElementIndex, by: -1)
        {
            let element = self.array?[elementIndex]
            let elementAbove = self.array![elementIndex - 1]
            
            if element > elementAbove
            {
                swapElementsAtIndices(index1: elementIndex - 1, index2: elementIndex)
            }
        }
    }
}
