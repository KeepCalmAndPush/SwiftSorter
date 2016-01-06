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

class SortingViewController: UIViewController, SorterPickerViewControllerDelegate
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
            _sorter?.diagramView = diagramView
            _sorter?.array = sourceArray;
                
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
    
    private var _sorterPickerVC : SorterPickerViewController?
    var sorterPickerVC : SorterPickerViewController
    {
        get
        {
            if let picker = _sorterPickerVC
            {
                return picker
            }
            
            
            _sorterPickerVC = SorterPickerViewController()
            _sorterPickerVC?.delegate = self
            
            return _sorterPickerVC!
        }
        
        set(newSorterPickerVC)
        {
            _sorterPickerVC = newSorterPickerVC
        }
    }
    
    
    ////

    private func fillArray()
    {
//        _sourceArray = [2, 3, 4, 5, 6, 7, 8, 9, 10, 1]
        
        for element in 1...arrayLength
        {
            _sourceArray.append(element)
        }
        
        _sourceArray.shuffle()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Сортировки"
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.sorter = SelectionSorter()
        
        placeNavbarButtons()

        fillArray()
        
        self.diagramView?.array = self.sourceArray
    }
    
    private func placeNavbarButtons()
    {
        restartSortingButtonItem = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "restartSorting:")
        showSortingAlgorithmsButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "showSortersPicker:")
        shuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "shuffleArray:")
        
        self.navigationItem.leftBarButtonItems = [showSortingAlgorithmsButtonItem!, shuffleButtonItem!]
        self.navigationItem.rightBarButtonItems = [restartSortingButtonItem!]
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
        self.diagramView = nil
        
        let sourceArray = self.sourceArray;
        self.sorter?.array = sourceArray;
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
        
        restartSortingButtonItem?.enabled = true
        shuffleButtonItem?.enabled = true
    }
    
     func pickerViewDidPickSorter(pickerView : SorterPickerViewController, sorter: Sorter)
     {
        self.sorter = sorter
        
        prepareForSorting()

        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSortersPicker(sender : UIBarButtonItem)
    {
        self.sorterPickerVC.sorters = [SelectionSorter(), InsertionSorter(), BubbleSorter(), ShakerSorter(), GnomeSorter()]
        let pickerNavController = UINavigationController(rootViewController: self.sorterPickerVC)
        self.presentViewController(pickerNavController, animated: true, completion: nil)
    }

    func shuffleArray(sender : UIBarButtonItem)
    {
        self.sorter?.stop()
        self.sourceArray!.shuffle()
        prepareForSorting()
    }
}

