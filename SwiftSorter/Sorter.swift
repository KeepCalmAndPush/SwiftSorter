//
//  Sorter.swift
//  SwiftSorter
//
//  Created by Андрей on 04.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class Sorter: NSObject
{
    var algorithmName : String = ""
    
    private var _array : [Int]?

    internal var stopped = false
    internal var refreshInterval = 0.3
    
    var array : [Int]?
    {
        get
        {
            _array = _array ?? []
            
            return _array
        }
        
        set(newArray)
        {
            _array = newArray
            
            _array = _array ?? []
            
            diagramView?.array = _array!
        }
    }
    
    private var _diagramView : DiagramView?
    var diagramView : DiagramView?
    {
        get
        {
            return _diagramView
        }
        
        set(newDiagramView)
        {
            _diagramView = newDiagramView
            _diagramView?.refreshInterval = self.refreshInterval
            _diagramView?.array = self.array!
        }
    }
    
    func sort()
    {
        sortArray(self.array!)
    }
    
    func sortArray(arrayToSort: [Int])
    {
        //Override
    }
    
    func stop()
    {
        self.stopped = true
        self.diagramView = nil
        self.array = nil
    }
    
    func swapElementsAtIndices(index1 index1: Int, index2 : Int, var inArray array: [Int])
    {
        let currentElement = array[index1]
        let currentMinElement = array[index2]
        
        array[index1] = currentMinElement
        array[index2] = currentElement
        
        self.diagramView?.swapElements(fromIndex: index1, toIndex: index2)
    }
}
