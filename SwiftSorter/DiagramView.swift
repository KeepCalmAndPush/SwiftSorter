//
//  DiagramView.swift
//  SwiftSorter
//
//  Created by Андрей on 03.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class DiagramView: UIView
{
    private var _array : [Int] = []
    
    private var viewsOrdinanceDict : [Int : UIView] = [Int : UIView]()
    
    private var maxElement : Int!
    
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
            
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
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
        clearDiagram()
        
        for index in 0..<self.array.count
        {
            let elementView = viewForElementAtIndex(index)
            
            self.contentView.addSubview(elementView)
            
            self.viewsOrdinanceDict[index] = elementView
        }
    }
    
    private func clearDiagram()
    {
        for subview in self.contentView.subviews
        {
            subview.removeFromSuperview()
        }
    }
    
    private func viewForElementAtIndex(index: Int) -> UIView
    {
        let element = _array[index]
        
        let elementHeight = CGFloat(element) * (self.contentView.bounds.size.height / CGFloat(maxElement))
        
        let elementOriginX = elementInterval + CGFloat(index) * (elementInterval + elementWidth)
        let elementOriginY = self.contentView.bounds.height - elementHeight
        
        let elementFrame = CGRect(origin: CGPoint(x:elementOriginX, y:elementOriginY),
                                    size: CGSize(width:elementWidth, height:elementHeight))
        
        
        let view = UIView(frame: elementFrame)
        
//        let component = CGFloat(maxElement) * CGFloat(element) / 255.0
//        
//        let color = UIColor(red: 1.0, green:1-component, blue:0, alpha:1.0)
        view.backgroundColor = UIColor.blueColor()
        
        return view
    }
    
    func swapElements(fromIndex fromIndex : Int, toIndex : Int)
    {
        let firstView = self.viewsOrdinanceDict[fromIndex]
        let secondView = self.viewsOrdinanceDict[toIndex]
        
        var swappedFirstViewFrame = firstView?.frame;
        var swappedSecondViewFrame = secondView?.frame;
        
        swappedFirstViewFrame?.origin.x = (secondView?.frame.origin)!.x
        swappedSecondViewFrame?.origin.x = (firstView?.frame.origin)!.x
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            firstView?.frame = swappedFirstViewFrame!
            secondView?.frame = swappedSecondViewFrame!
        });
        
        self.viewsOrdinanceDict[fromIndex] = secondView
        self.viewsOrdinanceDict[toIndex] = firstView
    }
    
    func highlightElementAtIndex(index : Int)
    {
        let viewAtIndex = self.viewsOrdinanceDict[index]
        viewAtIndex?.backgroundColor = UIColor.redColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.array.count == 0
        {
            return;
        }
        
        self.contentView.frame = CGRectInset(self.bounds, 10.0, 10.0)
        
        processArray()
        prepareConstants()
        
        clearDiagram()
        drawDiagram()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
