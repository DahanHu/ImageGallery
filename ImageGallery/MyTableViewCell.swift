//
//  MyTableViewCell.swift
//  ImageGallery
//
//  Created by 胡大函 on 14/11/5.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell,ScaleImageViewDelegate {

    var imgView: ScaleImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView = ScaleImageView(frame: CGRectZero, andDelegate: self)
        self.imgView.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300)))
        self.imgView.imageView.image = UIImage(named: "1.jpg")
        self.imgView.backgroundColor = UIColor.redColor()
//        self.imgView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
//        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.imgView)
        //self.contentView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        
    }
    
    func imageViewScale(imageScale: ScaleImageView!, clickCurImage imageview: UIImageView!) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
    }
    
    func setImgViewImage(#imageNamed: String) {
        self.imgView.asset = imageNamed
        self.imgView.imageView.image = UIImage(named: imageNamed)
    }
}
