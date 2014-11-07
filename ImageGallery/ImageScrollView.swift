//
//  ImageScrollView.swift
//  ImageGallery
//
//  Created by 胡大函 on 14/11/6.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

protocol ImageScrollViewDelegate {
    func tapImageViewTappedWithObject(#sender: AnyObject);
}

class ImageScrollView: UIScrollView {
    
    var i_delegate: ImageScrollViewDelegate!
    var imgView: UIImageView!
    /* 记录自己的位置 */
    var scaleOriginRect: CGRect!
    // 图片的大小
    var imgSize: CGSize!
    // 缩放前大小
    var initRect: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bouncesZoom = true
        self.backgroundColor = UIColor.clearColor()
        self.delegate = self
        self.minimumZoomScale = 1
        
        self.imgView = UIImageView()
        self.imgView.clipsToBounds = true
        self.imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(self.imgView)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
// MARK: Custom method
extension ImageScrollView {
    func setContentWithFrame(#rect: CGRect) {
        self.imgView.frame = rect
        self.initRect = rect
    }
    func setAnimationRect() {
        self.imgView.frame = self.scaleOriginRect
    }
    func rechangeInitRect() {
        self.zoomScale = 1
        self.imgView.frame = self.initRect
    }
    func setImage(#image: UIImage) {
        self.imgView.image = image
        self.imgSize = image.size
        
        //判断首先缩放的值
        let scaleX = self.frame.size.width / self.imgSize.width
        let scaleY = self.frame.size.height / self.imgSize.height
        
        //倍数小的,先到边缘
        if scaleX > scaleY {
            // Y方向先到边缘
            let imgViewWidth = self.imgSize.width * scaleY
            self.maximumZoomScale = self.frame.size.width / imgViewWidth
            
            self.scaleOriginRect = CGRect(x: self.frame.size.width / 2 - imgViewWidth / 2, y: 0, width: imgViewWidth, height: self.frame.size.height)
        } else {
            // X方向先到边缘
            let imgViewHeight = self.imgSize.height * scaleX
            self.maximumZoomScale = self.frame.size.height / imgViewHeight
            
            self.scaleOriginRect = CGRect(x: 0, y: self.frame.size.height / 2 - imgViewHeight / 2, width: self.frame.size.width, height: imgViewHeight)
        }
    }
}
// MARK: UIScrollViewDelegate
extension ImageScrollView: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size
        let imgFrame = self.imgView.frame
        let contentSize = scrollView.contentSize
        var centerPoint = CGPointMake(contentSize.width / 2, contentSize.height / 2)
        
        // center horizontally
        if imgFrame.size.width <= boundsSize.width {
            centerPoint.x = boundsSize.width / 2
        }
        // center vertically
        if imgFrame.size.height <= boundsSize.height {
            centerPoint.y = boundsSize.height / 2
        }
        self.imgView.center = centerPoint
    }
}
// MARK: touch
extension ImageScrollView {
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if self.i_delegate != nil {
            self.i_delegate.tapImageViewTappedWithObject(sender: self)
        }
    }
}
