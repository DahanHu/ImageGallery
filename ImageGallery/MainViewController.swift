//
//  MainViewController.swift
//  ImageGallery
//
//  Created by 胡大函 on 14/11/6.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit
let identifier: NSString = "identifier"
class MainViewController: UIViewController {

  var myTable: UITableView!
  var myScrollView: UIScrollView!
  var currentIndex: NSInteger!
  var markView: UIView!
  var scrollPanel: UIView!
  var tapCell: UITableViewCell!
  var lastImgScrollView: ImageScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.scrollPanel = UIView(frame: self.view.bounds)
    self.scrollPanel.backgroundColor = UIColor.clearColor()
    self.scrollPanel.alpha = 0
    self.view.addSubview(self.scrollPanel)
    
    self.markView = UIView(frame: self.scrollPanel.bounds)
    self.markView.backgroundColor = UIColor.blackColor()
    self.markView.alpha = 0
    self.scrollPanel.addSubview(self.markView)
    
    self.myScrollView = UIScrollView(frame: self.view.bounds)
    self.scrollPanel.addSubview(self.myScrollView)
    self.myScrollView.pagingEnabled = true
    self.myScrollView.delegate = self
    
    var contentSize: CGSize = self.myScrollView.contentSize
    contentSize.height = self.view.bounds.size.height
    contentSize.width = 320 * 3
    self.myScrollView.contentSize = contentSize
    
    self.myTable = UITableView(frame: self.view.bounds)
    self.myTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
    self.myTable.dataSource = self
    self.myTable.delegate = self
    self.view.addSubview(self.myTable)
    
  }

}
// MARK: UITableViewDelegate and UITableViewDatasource
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
    for i in 0...2 {
      let tmpView = TapImageView(frame: CGRect(x: CGFloat(5 + 105 * i), y: 10, width: 100, height: 100))
      tmpView.t_delegate = self
      tmpView.image = UIImage(named: "\(i + 1).jpg")
      tmpView.tag = 10 + i
      cell.contentView.addSubview(tmpView)
      tmpView.identifier = cell
    }
    return cell
  }

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 150
  }
}
// MARK: UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    let pageWidth: CGFloat = scrollView.frame.size.width
    self.currentIndex = NSInteger(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
  }
}
// MARK: Custom method
extension MainViewController {
  func addSubImgView() {
    for view in self.myScrollView.subviews {
      view.removeFromSuperview()
    }
    for i in 0...2 {
      if i == currentIndex {
        continue
      }
      let tmpView: TapImageView = tapCell.viewWithTag(10 + i) as TapImageView
        
      //转换后的Rect
      let convertRect: CGRect = tmpView.superview!.convertRect(tmpView.frame, toView: self.view)
      let x = CGFloat(NSInteger(self.myScrollView.bounds.size.width) * i)
      let tempImgScrollView = ImageScrollView(frame: CGRect(origin: CGPointMake(x, 0), size: self.myScrollView.bounds.size))
      tempImgScrollView.setContentWithFrame(rect: convertRect)
      tempImgScrollView.setImage(image: tmpView.image!)
      self.myScrollView.addSubview(tempImgScrollView)
      tempImgScrollView.i_delegate = self
      tempImgScrollView.setAnimationRect()
    }
  }
  
  func setOriginFrame(#sender: ImageScrollView) {
    UIView.animateWithDuration(0.4, animations: {
      sender.setAnimationRect()
      self.markView.alpha = 1
    })
  }
}
// MARK: Custom delegate
extension MainViewController: ImageScrollViewDelegate,TapImageViewDelegate {
  func tapImageViewTappedWithObject(#sender: AnyObject) {
    let tmpImgView: ImageScrollView = sender as ImageScrollView
    UIView.animateWithDuration(0.5, animations: {
      self.markView.alpha = 0
      tmpImgView.rechangeInitRect()
    }, completion: { finished in
      self.scrollPanel.alpha = 0
    })
  }
  func tappedWithObject(#sender: AnyObject) {
    self.view.bringSubviewToFront(self.scrollPanel)
    self.scrollPanel.alpha = 1
    let tmpView: TapImageView = sender as TapImageView
    self.currentIndex = tmpView.tag - 10
    
    self.tapCell = tmpView.identifier as UITableViewCell
    
    //转换后的Rect
    let converRect = tmpView.superview?.convertRect(tmpView.frame, toView: self.view)
    var contentOffset = self.myScrollView.contentOffset
    contentOffset.x = CGFloat(self.currentIndex * 320)
    self.myScrollView.contentOffset = contentOffset
    
    //添加
    self.addSubImgView()
      
    let tmpImgScrollView = ImageScrollView(frame: CGRect(origin: contentOffset, size: self.myScrollView.bounds.size))
    tmpImgScrollView.setContentWithFrame(rect: converRect!)
    tmpImgScrollView.setImage(image: tmpView.image!)
    self.myScrollView.addSubview(tmpImgScrollView)
    tmpImgScrollView.i_delegate = self
    self.setOriginFrame(sender: tmpImgScrollView)
  }
}
