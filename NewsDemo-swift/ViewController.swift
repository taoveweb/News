//
//  ViewController.swift
//  NewsDemo-swift
//
//  Created by 黄 家金 on 16/7/21.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,TitleSegmentDelegate {

    var tableVew = UITableView()
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    var newsArray:NSArray? = []
    
    var imageURLArray:Array<String>?
    var topView :ScrollImageView?
    var segment:TitleSegment?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        setupLayout()
        setupSubview()
        
        setupData()
        getDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
    
    // MARK: - ViewSetup
    
    func addSubView(){
        self.segment = TitleSegment.init(frame: CGRectMake(0, 20, self.view.bounds.width, 30))
        self.view.addSubview(tableVew)
        self.view.addSubview(segment!)
        //self.view.addSubview(topView!)
    }
    
    
    func setupLayout(){
        
        self.tableVew.frame = CGRectMake(0, 50, self.view.bounds.width, self.view.bounds.height)
        self.topView = ScrollImageView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 150))
        
    }
    
    func setupSubview(){
        
        self.tableVew.delegate = self
        self.tableVew.dataSource = self
        self.segment?.delegate = self
        self.tableVew.rowHeight = 100
        self.tableVew.registerClass(SnapTableViewCell.self, forCellReuseIdentifier: CellSnap)
        self.tableVew.registerClass(ImageTableViewCell.self, forCellReuseIdentifier: CellImage)
        
    }
    
    
    // MARK: - private
    
    func getDataFromServer(){
        
        let url = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=goMk9xEaxb9mEwxNwluKjtp8hhzCyTnWn8pPG0WnJOsN4xIDbc6Cnl0HqWawjLtN&size=20&version=12.0&spever=false&net=wifi&lat=&lon=&ts=1469141330&sign=Dje5naF3Y4yJ%2FXg%2BkCR4g2fNxjW3i9KWzopOm1EePRh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        Alamofire.request(Method.GET,url ).responseJSON { (Response) in
            
            
            switch Response.result {
            case .Success:
                if let dic:NSDictionary = Response.result.value as? NSDictionary {
                    if  let tempArray = dic["T1348647853363"] as? NSArray {
                        
                        let dataArray = tempArray.subarrayWithRange(NSRange(location: 0, length: (tempArray.count)-1))
                        self.newsArray  = dataArray
                        self.tableVew.reloadData()
                    }
                }
            case .Failure:
                print(Response.result.error)
            }
           
            
           
        }
        
    }
    
    
    func setupData(){
        self.segment?.titleArray = ["01","02","03","04", "05","06", "07","03","04", "05","06", "07"]
    }
    
    
    // MASK: - delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let count = (self.newsArray?.count) {
            return count
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            
        
        
            let cell:SnapTableViewCell = tableVew.dequeueReusableCellWithIdentifier(CellSnap) as! SnapTableViewCell
            if let data:NSDictionary = self.newsArray![indexPath.row] as? NSDictionary {
                cell.titleLabel.text  = data["title"] as? String
                cell.detailLabel.text = data["digest"] as? String
                if let url:String = data["img"] as? String{
                     cell.testImageView.kf_setImageWithURL(NSURL.init(string:url))
                }
            }
            
            
            return cell
        }
        else{
            
            let cell:ImageTableViewCell = tableVew.dequeueReusableCellWithIdentifier(CellImage) as! ImageTableViewCell
            let data:NSDictionary = self.newsArray![indexPath.row] as! NSDictionary
            let url:String = data["img"] as! String

            cell.titleLable.text  = data["title"] as? String
            cell.bigImageView.kf_setImageWithURL(NSURL.init(string:url))
            return cell
            
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 100.0
        }else{
            return 150.0
        }
    }
    
    func buttonDidClicked(index: Int) {
        print(index)
    }

}

