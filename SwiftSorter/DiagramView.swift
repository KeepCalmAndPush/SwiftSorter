//
//  DiagramView.swift
//  SwiftSorter
//
//  Created by Андрей on 03.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

let defaultElementColor = UIColor.blueColor()
let selectionColor = UIColor.yellowColor()
let successfulComparisonColor = UIColor.greenColor()
let failedComparisonColor = UIColor.redColor()
let diagramBackgroundColor = UIColor.lightGrayColor()

let runLoopTimeInterval = 0.2
let swapAnimationDuration = 0.1

class DiagramView: UIView
{
    private var _array : [Int] = []
    
    private var viewsOrdinanceDict : [Int : UIView] = [Int : UIView]()
    
    private var maxElement : Int!
    private var selectedElementAtIndex : Int?
    
    private var elementWidth : CGFloat = 0
    private var elementInterval : CGFloat = 0
    
    private var _contentView : UIView? = nil
    private var contentView : UIView!
    {
        if _contentView == nil
        {
            _contentView = UIView(frame: CGRectInset(self.bounds, 10.0, 10.0))
            _contentView?.backgroundColor = self.backgroundColor
            
            self.addSubview(_contentView!)
        }
        
        return _contentView
    }
    
    var array : [Int]
    {
        get
        {
            return _array
        }
        
        set(newArray)
        {
            _array = newArray
            
            if _array.count > 0
            {
                processArray()
            }
            
            setNeedsLayout()
        }
    }
    
    var refreshInterval : NSTimeInterval = runLoopTimeInterval
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = diagramBackgroundColor
    }
    
    private func processArray()
    {
        let minElement = _array.minElement()! - 1
        let map = {return $0 - minElement}
        
        _array = _array.map(map)
    }
    
    private func prepareConstants()
    {
        maxElement = _array.maxElement()!
        elementWidth = self.contentView.bounds.size.width / CGFloat(2 * _array.count + 1)
        elementInterval = elementWidth
    }
    
    private func drawDiagram()
    {
        for index in 0..<self.array.count
        {
            drawElementAtIndex(index)
        }
    }
    
    private func drawElementAtIndex(index: Int)
    {
        var view = viewsOrdinanceDict[index]
        
        if view == nil
        {
            view = UIView()
            self.contentView.addSubview(view!)
            self.viewsOrdinanceDict[index] = view!
            deselectElementAtIndex(index)
        }
        
        let element = _array[index]
        
        let elementHeight = CGFloat(element) * (self.contentView.bounds.size.height / CGFloat(maxElement))
        
        let elementOriginX = elementInterval + CGFloat(index) * (elementInterval + elementWidth)
        let elementOriginY = self.contentView.bounds.height - elementHeight
        
        let elementFrame = CGRect(origin: CGPoint(x:elementOriginX, y:elementOriginY),
                                    size: CGSize(width:elementWidth, height:elementHeight))
        
        
        view!.frame = elementFrame
    }
    
    func swapElements(fromIndex fromIndex : Int, toIndex : Int)
    {
        let firstView = self.viewsOrdinanceDict[fromIndex]
        let secondView = self.viewsOrdinanceDict[toIndex]
        
        var swappedFirstViewFrame = firstView?.frame;
        var swappedSecondViewFrame = secondView?.frame;
        
        swappedFirstViewFrame?.origin.x = (secondView?.frame.origin)!.x
        swappedSecondViewFrame?.origin.x = (firstView?.frame.origin)!.x
        
        UIView.animateWithDuration(swapAnimationDuration, animations: { () -> Void in
            firstView?.frame = swappedFirstViewFrame!
            secondView?.frame = swappedSecondViewFrame!
        });
        
        self.viewsOrdinanceDict[fromIndex] = secondView
        self.viewsOrdinanceDict[toIndex] = firstView
        
        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: swapAnimationDuration))
    }
    
    func selectElementAtIndex(index : Int)
    {
        deselectElementAtIndex(selectedElementAtIndex)
        
        let viewAtIndex = self.viewsOrdinanceDict[index]
        viewAtIndex?.backgroundColor = selectionColor
        
        selectedElementAtIndex = index
        
        delay()
    }
    
    func highlightComparisonSucceededForElementAtIndex(elementIndex : Int, comparedToElementAtIndex : Int)
    {
        clearSelection()
        
        let elementView = self.viewsOrdinanceDict[elementIndex]
        let comparisonElementView = self.viewsOrdinanceDict[comparedToElementAtIndex]
        
        elementView?.backgroundColor = selectionColor
        comparisonElementView?.backgroundColor = successfulComparisonColor
        
        delay()
    }
    
    func highlightComparisonFailedForElementAtIndex(elementIndex : Int, comparedToElementAtIndex : Int)
    {
        clearSelection()
        
        let elementView = self.viewsOrdinanceDict[elementIndex]
        let comparisonElementView = self.viewsOrdinanceDict[comparedToElementAtIndex]
        
        elementView?.backgroundColor = selectionColor
        comparisonElementView?.backgroundColor = failedComparisonColor
        
        delay()
    }
    
    func deselectElementAtIndex(index : Int?)
    {
//        if let currentlyHighlightedViewIndex =  index
//        {
//            let currentlyHighlightedView = self.viewsOrdinanceDict[currentlyHighlightedViewIndex]
//            currentlyHighlightedView?.backgroundColor = UIColor.blueColor()
//        }
        
        clearSelection()
    }
    
    func clearSelection()
    {
        for view : UIView in self.contentView.subviews
        {
            view.backgroundColor = defaultElementColor
        }
    }
    
    func delay()
    {
        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: refreshInterval))
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if self.array.count == 0
        {
            return;
        }
        
        self.contentView.frame = CGRectInset(self.bounds, 10.0, 10.0)

        prepareConstants()
        
        drawDiagram()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
