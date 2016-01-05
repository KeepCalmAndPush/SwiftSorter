//
//  SorterPickerViewController.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

protocol SorterPickerViewControllerDelegate
{
    func pickerViewDidPickSorter(pickerView : SorterPickerViewController, sorter: Sorter);
}

class SorterPickerViewController: UITableViewController
{
    var sorters : [Sorter] = [Sorter]()
    var delegate : SorterPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Выберите алгоритм"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SorterCell")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.sorters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("SorterCell")!
        
        let sorter = sorterForIndex(indexPath.row)
        
        cell.textLabel?.text = sorter.algorithmName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let sorter = sorterForIndex(indexPath.row)
        delegate?.pickerViewDidPickSorter(self, sorter: sorter)
    }
    
    func sorterForIndex(index : Int) -> Sorter
    {
        let sorter = self.sorters[index]
        
        return sorter
    }
}
