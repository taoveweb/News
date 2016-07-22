

//
//  TitleSegment.swift
//  NewsDemo-swift
//
//  Created by 淘未 on 16/7/22.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit

protocol TitleSegmentDelegate :class {
    func buttonDidClicked (index :Int)
}

class TitleSegment: UIView {
    
    weak var delegate : TitleSegmentDelegate?
    var buttonTagBase = 100
    var index :Int = 100
    var titleArray:Array<String>? {
        
        didSet{
            createTitleViews()
        }
        
    }
    
    lazy var scrollView:UIScrollView = {
        let temp = UIScrollView();
        temp.showsHorizontalScrollIndicator = false
        temp.backgroundColor = UIColor.redColor()
        
       return temp
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.addSubview(scrollView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    
    func createTitleViews(){
        
        for subView in self.scrollView.subviews {
            subView.removeFromSuperview()
        }
        
        if let count = titleArray?.count {
            
            let width:CGFloat = 80
            for i in 0..<count {
                
                
                let button = UIButton()
                button.frame = CGRectMake(CGFloat(i) * width, 0, width, self.frame.size.height)
                button.backgroundColor = UIColor.greenColor()
                button.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                button.tag = i + buttonTagBase
                self.scrollView.addSubview(button)
                button.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

                if let title = self.titleArray?[i] {
                    button.setTitle(title, forState: UIControlState.Normal)
                }
                print(i + buttonTagBase,self.index)
                if i + buttonTagBase  == self.index {
                    button.selected = true
                }
                
            }
            
            
            scrollView.contentSize = CGSizeMake(width * CGFloat(count ), self.frame.size.height)
        }
        
        
    }
    
    
    
    func buttonClicked( button:UIButton){
        if let tempButton = self.scrollView.viewWithTag(self.index) as? UIButton {
           tempButton.selected = false
        }
        button.selected = true
        self.delegate?.buttonDidClicked(button.tag - buttonTagBase)
        self.index = button.tag
    }
    
    

}
