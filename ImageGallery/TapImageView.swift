//
//  TapImageView.swift
//  ImageGallery
//
//  Created by 胡大函 on 14/11/6.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

protocol TapImageViewDelegate {
    func tappedWithObject(#sender: AnyObject);
}

class TapImageView: UIImageView {

    var identifier: AnyObject!
    var t_delegate: TapImageViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
        self.addGestureRecognizer(tap)
        
        self.clipsToBounds = true
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.userInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tapped(recognizer: UITapGestureRecognizer) {
        if self.t_delegate != nil {
            self.t_delegate.tappedWithObject(sender: self)
        }
    }
    
}
