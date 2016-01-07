//
//  ViewController.swift
//  SwiftSorter
//
//  Created by Андрей on 03.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

let arrayLength = 10

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            
            if i != j
            {
                swap(&self[i], &self[j])
            }
        }
    }
}

class SortingViewController: UIViewController
{
    var restartSortingButtonItem : UIBarButtonItem?
    var showSortingAlgorithmsButtonItem : UIBarButtonItem?
    var shuffleButtonItem : UIBarButtonItem?
    
    
    private var _sorter : Sorter?
    var sorter : Sorter?
    {
        get
        {
            return _sorter
        }
        
        set(newSorter)
        {
            _sorter?.stop()
            
            _sorter = newSorter
            _sorter?.array = self.sourceArray
            _sorter?.diagramView = self.diagramView

            self.title = _sorter?.algorithmName
        }
    }
    
    var _diagramView : DiagramView! = nil
    var diagramView : DiagramView?
    {
        get
        {
            if _diagramView == nil
            {
                _diagramView = DiagramView(frame:self.view.bounds)
                
                self.view.addSubview(_diagramView)
            }
            
            return _diagramView
        }
        
        set(newDiagram)
        {
            if newDiagram == nil
            {
                _diagramView?.removeFromSuperview()
            }
            
            _diagramView = newDiagram
        }
    }
    
    private var  _sourceArray : [Int] = []
    var sourceArray : [Int]!
    {
        get
        {
            if _sourceArray.isEmpty
            {
                self.fillArray()
            }
            
            return _sourceArray
        }
        set(newArray)
        {
            _sourceArray = newArray
        }
    }

    private func fillArray()
    {
        _sourceArray.removeAll()
        
        for element in 1...arrayLength
        {
            _sourceArray.append(element)
        }
        
        _sourceArray.shuffle()
//        _sourceArray = [44, 55, 12, 42, 94, 18, 06, 67]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Сортировки"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        fillArray()
        
        placeNavbarButtons()
    }
    
    private func placeNavbarButtons()
    {
        restartSortingButtonItem = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "restartSorting:")
        showSortingAlgorithmsButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "showSortersPicker:")
        shuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "shuffleArray:")
        
        self.navigationItem.rightBarButtonItems = [shuffleButtonItem!, restartSortingButtonItem!]
//        self.navigationItem.rightBarButtonItems = [restartSortingButtonItem!]
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        let statusBarOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if UIInterfaceOrientationIsLandscape(statusBarOrientation)
        {
            self.diagramView!.frame = self.view.bounds
        }
        else
        {
            let frame = CGRect(x: 0,
                               y: (self.view.bounds.height - (self.view.bounds.width - 0)) / 2,
                           width: self.view.bounds.width - 0,
                          height: self.view.bounds.width)
            
            self.diagramView!.frame = frame
        }
        self.diagramView!.layoutIfNeeded()
    }
    
    private func prepareForSorting()
    {
        let sourceArray_ = _sourceArray;
        
        self.sorter?.array = sourceArray_//[44, 55, 12, 42, 94, 18, 06, 67]
        self.sorter?.diagramView = self.diagramView
    }

    private func startSorting()
    {
        prepareForSorting()
        sorter?.sort()
    }
    
    func restartSorting(sender : UIBarButtonItem)
    {
        restartSortingButtonItem?.enabled = false
        shuffleButtonItem?.enabled = false

         startSorting()
//        sorter?.sort()
        
        restartSortingButtonItem?.enabled = true
        shuffleButtonItem?.enabled = true
    }

    func shuffleArray(sender : UIBarButtonItem)
    {
        self.sorter?.stop()
        self.sourceArray!.shuffle()
        prepareForSorting()
    }
}

