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

class SortingDiagramViewController: UIViewController, SorterPickerViewDelegate
{
    var sorter : Sorter?
    
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
    }
    
    private var _sorterPicker : SorterPickerView?
    var sorterPicker  : SorterPickerView
    {
        get
        {
            if let picker = _sorterPicker
            {
                return picker
            }
            
            
            _sorterPicker = SorterPickerView(frame: self.view.bounds)
            _sorterPicker?.sorters = [SelectionSorter(), InsertionSorter(), BubbleSorter()]
            _sorterPicker?.delegate = self
            _sorterPicker?.hidden = true
            
            self.view.addSubview(_sorterPicker!)
            
            return _sorterPicker!
        }
    }
    
    
    ////

    private func fillArray()
    {
        _sourceArray = []
        
        for element in 1...arrayLength
        {
            _sourceArray.append(element)
        }
        
        _sourceArray.shuffle()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Сортировки"
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.sorter = SelectionSorter()
        self.title = self.sorter?.algorithmName
        
        placeNavbarButtons()

        fillArray()
        
        self.diagramView?.array = self.sourceArray
    }
    
    private func placeNavbarButtons()
    {
        let restartSortingButtonItem = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "restartSorting:")
        let showSortingAlgorithmsButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "showSortingAlgorithmsButtonItemTapped:")
        let shuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "restartSorting:")
        
        self.navigationItem.rightBarButtonItems = [showSortingAlgorithmsButtonItem, shuffleButtonItem, restartSortingButtonItem]
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
        
        self.sorterPicker.frame = self.view.bounds

        self.diagramView!.layoutIfNeeded()
    }

    private func startSorting()
    {
        var arrayCopy = self.sourceArray
    
        sorter?.diagramView = self.diagramView
        sorter?.array = arrayCopy;
        
        sorter?.sort()
    }
    
    func restartSorting(sender : UIBarButtonItem)
    {
        sender.enabled = false
        
        self.sorter?.stop()
        self.diagramView = nil
        
        startSorting()
        
        sender.enabled = true
    }
    
     func pickerViewDidPickSorter(pickerView : SorterPickerView, sorter: Sorter)
     {
        self.sorter = sorter
        
        self.title = self.sorter?.algorithmName
    }
    
    func showSortingAlgorithmsButtonItemTapped(sender : UIBarButtonItem)
    {
        if self.sorterPicker.hidden
        {
            showSorterPicker()
        }
        else
        {
            hideSorterPicker()
        }
    }
    
    func showSorterPicker()
    {
        self.view.insertSubview(self.sorterPicker, aboveSubview: self.diagramView!)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.sorterPicker.hidden = false
        }
    }
    
    func hideSorterPicker()
    {
        UIView.animateWithDuration(0.5,
            animations: { () -> Void in
                self.sorterPicker.hidden = true
            },
            completion: {(finised : Bool) -> Void in
                self.sorterPicker.removeFromSuperview()
            })
    }
}

