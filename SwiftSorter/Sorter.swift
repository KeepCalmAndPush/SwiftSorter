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
    var diagramView : DiagramView?
    
    internal var stopped = false
    
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
}
