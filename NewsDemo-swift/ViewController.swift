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

   
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    var newsArray:NSArray? = []
    
    var imageURLArray:Array<String>?
    lazy var topView :ScrollImageView = {
        let temp = ScrollImageView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 190))
        
        return temp
    }()
    lazy var segment:TitleSegment = {
        
        let temp =  TitleSegment.init(frame: CGRectMake(0, 20, self.view.bounds.width, 40))
        temp.titleArray = ["01","02","03","04", "05","06", "07","03","04", "05","06", "07"]
        temp.delegate = self
        return temp
        
    }()
    
    lazy var tableVew: UITableView = {
        let temp = UITableView.init(frame: CGRectMake(0, 50, self.view.bounds.width, self.view.bounds.height - 40 - 64 ))
        temp.delegate = self
        temp.dataSource = self
     

        return temp
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavagationBar()
        addSubView()
        setupLayout()
        setupSubview()
  
        getDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
    func setupNavagationBar(){
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0.86, green: 0.2, blue: 0.22, alpha: 1)
    }
    
    
    
    // MARK: - ViewSetup
    
    func addSubView(){
        self.view.addSubview(tableVew)
        self.view.addSubview(segment)
        
        self.tableVew.registerClass(SnapTableViewCell.self, forCellReuseIdentifier: CellSnap)
        self.tableVew.registerClass(ImageTableViewCell.self, forCellReuseIdentifier: CellImage)
        //self.view.addSubview(topView!)
    }
    
    
    func setupLayout(){
        
  
 
        
    }
    
    func setupSubview(){
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
    }
    
    
    // MARK: - private
    
    func getDataFromServer(){
        
        let url = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=goMk9xEaxb9mEwxNwluKjtp8hhzCyTnWn8pPG0WnJOsN4xIDbc6Cnl0HqWawjLtN&size=20&version=12.0&spever=false&net=wifi&lat=&lon=&ts=1469141330&sign=Dje5naF3Y4yJ%2FXg%2BkCR4g2fNxjW3i9KWzopOm1EePRh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        Alamofire.request(Method.GET,url ).responseJSON { (Response) in
            
            
            switch Response.result {
                
            case .Success:
                if let dic:NSDictionary = Response.result.value as? NSDictionary {
                    if  let tempArray = dic["T1348647853363"] as? NSArray {
                        
                        self.handleBannerData(tempArray)
                        
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
    

    
    
    func handleBannerData(dataArray:NSArray) {
        if let urlDic = dataArray[0] as? NSDictionary {
            
            if let adArray = urlDic["ads"] as? NSArray {
                
                self.topView.imageURLArray = adArray.map({ (adDic) -> String in
                    
                    if let url = adDic["imgsrc"] as? String {
                        print(url)
                        return url
                    }
                    
                    return ""
                    
                })
                
            }
        }
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

