//
//  MyTableViewController.swift
//  ImageGallery
//
//  Created by 胡大函 on 14/11/5.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

let screenSize: CGSize = UIScreen.mainScreen().bounds.size
let reuseIdentifier = "MyCell"

class MyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as MyTableViewCell

        // Configure the cell...
        //cell.setImgViewImage(imageNamed: "1.jpg")

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.size.width
    }
    
}
