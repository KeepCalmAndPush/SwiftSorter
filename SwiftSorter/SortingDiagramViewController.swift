//
//  ViewController.swift
//  SwiftSorter
//
//  Created by Андрей on 03.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

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

class SortingDiagramViewController: UIViewController
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
                
                _diagramView = newDiagram
            }
        }
    }
    
    var  _sourceArray : [Int] = []
    
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

    func fillArray()
    {
        _sourceArray = []
        
        for element in 1...25
        {
            _sourceArray.append(element)
        }
        
        _sourceArray.shuffle()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Глагне"
        self.navigationController?.navigationBar.translucent = false
        
        
        let uibb = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "restartSorting:")
        self.navigationItem.rightBarButtonItem = uibb

        fillArray()
        
        self.diagramView?.array = self.sourceArray
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
            let frame = CGRect(x: 10,
                               y: (self.view.bounds.height - (self.view.bounds.width - 0)) / 2,
                           width: self.view.bounds.width - 0,
                          height: self.view.bounds.width)
            
            self.diagramView!.frame = frame
        }

        self.diagramView!.layoutIfNeeded()
    }

    func startSorting()
    {
        var arrayCopy = self.sourceArray
        
        self.sorter = InsertionSorter()
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
}

