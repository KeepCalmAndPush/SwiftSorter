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
    private var _array : [Int]?
    private var _diagramView : DiagramView?
    
    var algorithmName : String = ""
    
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
        }
    }
    
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
    
    func sort()
    {
        //Override
    }
    
    func stop()
    {
        stopped = true
        diagramView = nil
        self.array = nil
    }
    
    func swapElementsAtIndices(index1 index1: Int, index2 : Int)
    {
        let currentElement = self.array![index1]
        let currentMinElement = self.array![index2]
        
        self.array![index1] = currentMinElement
        self.array![index2] = currentElement
        
        self.diagramView?.swapElements(fromIndex: index1, toIndex: index2)
    }
}
