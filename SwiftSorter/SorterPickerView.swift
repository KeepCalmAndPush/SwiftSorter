//
//  SorterPickerView.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

protocol SorterPickerViewDelegate
{
    func pickerViewDidPickSorter(pickerView : SorterPickerView, sorter: Sorter);
}

class SorterPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate
{
    var sorters : [Sorter] = [Sorter]()
    private var picker : UIPickerView
    var delegate : SorterPickerViewDelegate?
    
    override init(frame: CGRect)
    {
        picker = UIPickerView(frame: frame)

        super.init(frame: frame)
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(picker)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return sorters.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let pickedSorter : Sorter = sorters[row]
        
        return pickedSorter.algorithmName
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let pickedSorter : Sorter = sorters[row]
        
        delegate?.pickerViewDidPickSorter(self, sorter:pickedSorter)
    }
}
