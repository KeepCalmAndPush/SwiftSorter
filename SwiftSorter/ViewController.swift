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

class ViewController: UIViewController
{
    var _diagramView : DiagramView! = nil
    var diagramView : DiagramView
    {
        get
        {
            if _diagramView == nil
            {
                _diagramView = DiagramView(frame: CGRectInset(self.view.bounds, 10.0, 10.0))
            }
            
            return _diagramView
        }
    }
    
    var  srcarr : [Int] = []
    
    var sourceArray : [Int]!
    {
        get
        {
            if srcarr.isEmpty
            {
                self.fillArray()
            }
            
            return srcarr
        }
    }

    func fillArray()
    {
        srcarr = []
        
        for element in 1...25
        {
            srcarr.append(element)
        }
        
        srcarr.shuffle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
        self.title = "Глагне"
        self.navigationController?.navigationBar.translucent = false

        fillArray()
        
        self.diagramView.array = srcarr
        self.view.addSubview(diagramView)
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        let s = UIApplication.sharedApplication().statusBarOrientation
        
        if UIInterfaceOrientationIsLandscape(s)
        {
            self.diagramView.frame = CGRectInset(self.view.bounds, 10.0, 10.0)
        }
        else
        {
            let frame = CGRect(x: 10,
                               y: (self.view.bounds.height - (self.view.bounds.width - 20)) / 2,
                           width: self.view.bounds.width - 20,
                          height: self.view.bounds.width)
            
            self.diagramView.frame = frame
//            self.diagramView.center = self.view.center
        }
        
//
        self.diagramView.layoutIfNeeded()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.diagramView.swapElements(fromIndex: 1, toIndex: 20)
//        self.diagramView.swapElements(fromIndex: 2, toIndex: 24)
//        self.diagramView.swapElements(fromIndex: 3, toIndex: 23)
//        self.diagramView.swapElements(fromIndex: 4, toIndex: 22)
//        self.diagramView.swapElements(fromIndex: 5, toIndex: 21)
        
        self.diagramView.highlightElementAtIndex(10)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

