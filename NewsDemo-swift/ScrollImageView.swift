//
//  ScrollImageView.swift
//  NewsDemo-swift
//
//  Created by 淘未 on 16/7/22.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit
import Kingfisher

class ScrollImageView: UIView , UIScrollViewDelegate {
    
    var imageURLArray: Array<String>? {
    
        didSet{
            creatImageViews()
        }
    }
    let scrollView = UIScrollView()
    
    var timer :NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented" )
    }
    
    
    func creatImageViews(){
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
        
        if let count = imageURLArray?.count{
       
       
            for index in 0..<count{
                let imageView =  UIImageView()
                imageView.frame = CGRectMake(CGFloat(index) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)
            
                scrollView.addSubview(imageView)
                
                if let url = imageURLArray?[index] {
                    
                    imageView.kf_setImageWithURL(NSURL.init(string: url)!)
                }
            }
            
            let imageLeft = UIImageView.init(frame:CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            let imageRight = UIImageView.init(frame:CGRectMake(CGFloat(count) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            scrollView.addSubview(imageLeft)
            if let url = imageURLArray?[count-1] {
                imageLeft.kf_setImageWithURL(NSURL.init(string:url))
            }
            
            if let url = imageURLArray?[0] {
                imageRight.kf_setImageWithURL(NSURL.init(string:url))
            }

            
            scrollView.addSubview(imageRight)
            scrollView.contentInset =  UIEdgeInsetsMake(0, self.frame.size.width, 0, self.frame.size.width)
            
            
            scrollView.contentSize = CGSizeMake(CGFloat(count) * self.frame.size.width, self.frame.size.height)
            
        }
        
        if ((self.timer?.valid) != nil) {
            self.timer?.invalidate()
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ScrollImageView.timerHandle), userInfo: nil, repeats: true)
    }
    
    
    func timerHandle(){
        self.scrollView.setContentOffset(CGPointMake(self.scrollView.contentOffset.x + self.frame.size.width, 0), animated: true)
    }
    
    
    
    // MARK: - UISCROllvivedelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        
        if point.x == -self.frame.size.width {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - self.frame.size.width,y: 0), animated: false)
            
        }else if  point.x == scrollView.contentSize.width {
            scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
