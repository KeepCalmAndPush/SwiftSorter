//
//  SorterPickerViewController.swift
//  SwiftSorter
//
//  Created by Андрей on 05.01.16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class SorterPickerViewController: UITableViewController
{
    var sorters : [Sorter] = [Sorter]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Выберите алгоритм"
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SorterCell")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
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
        cell.accessoryType = .DisclosureIndicator
        cell.backgroundColor = self.view.backgroundColor
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let sorter = sorterForIndex(indexPath.row)
    
        let sortingController = SortingViewController()
        sortingController.sorter = sorter
        
        self.navigationController?.pushViewController(sortingController, animated: true)
    }
    
    func sorterForIndex(index : Int) -> Sorter
    {
        let sorter = self.sorters[index]
        
        return sorter
    }
}
