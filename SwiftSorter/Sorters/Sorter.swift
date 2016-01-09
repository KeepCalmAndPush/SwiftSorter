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
    var suitableElementsCount : Int = 15
    
    private var _array : [Int]?

    internal var refreshInterval = 0.3
    internal var animationDuration = 0.3
    
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
            
            self.diagramView?.array = _array!
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
            _diagramView?.animationDuration = self.animationDuration
            _diagramView?.array = self.array!
        }
    }
    
    func sort()
    {
        sortArray(&self.array!)
        
        self.diagramView?.clearSelection()
    }
    
    func sortArray(inout arrayToSort: [Int])
    {
        //Override
    }
    
    func stop()
    {
        self.diagramView = nil
        self.array = nil
    }

    func swapElementsAtIndices(index1 index1: Int, index2 : Int, inout inArray array: [Int])
    {
        let currentElement = array[index1]
        let currentOtherElement = array[index2]
        
        array[index1] = currentOtherElement
        array[index2] = currentElement
        
        self.diagramView?.swapElements(fromIndex: index1, toIndex: index2)
    }
}
