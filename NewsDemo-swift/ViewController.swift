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
import PullToRefresh
import SwiftyJSON

class ViewController: UIViewController  ,TitleSegmentDelegate {

   
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    //var newsArray:NSArray? = []
    var refresher = PullToRefresh()
    var imageURLArray:Array<String>?
    
    var tableviewProtocl:TableviewProtocol?
    
    
    lazy var segment:TitleSegment = {
        
        let temp =  TitleSegment.init(frame: CGRectMake(0, 0, self.view.bounds.width, 40))
        temp.titleArray = ["首页","婚乐","军事","热点", "体充","北京", "07","03","04", "05","06", "07"]
        temp.delegate = self
        return temp
        
    }()
    
    lazy var topView :ScrollImageView = {
        
        let temp = ScrollImageView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 190))
        return temp
        
    }()
    
    lazy var tableVew: UITableView = {
        
        let temp = UITableView.init(frame: CGRectMake(0, 50, self.view.bounds.width, self.view.bounds.height - 40 - 64 ))
        //temp.delegate = self
        //temp.dataSource = self
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
        
        self.tableVew.addPullToRefresh(self.refresher, action: {
            print("下接刷新")
            self.getDataFromServer()
        })
    }
    
    
    // MARK: - private
    
    func getDataFromServer(){
       
        let url = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=goMk9xEaxb9mEwxNwluKjtp8hhzCyTnWn8pPG0WnJOsN4xIDbc6Cnl0HqWawjLtN&size=20&version=12.0&spever=false&net=wifi&lat=&lon=&ts=1469141330&sign=Dje5naF3Y4yJ%2FXg%2BkCR4g2fNxjW3i9KWzopOm1EePRh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        Alamofire.request(Method.GET,url ).responseJSON { (Response) in
            
             self.tableVew.endRefreshing()
            switch Response.result {
                
            case let .Success(data):
                let json = JSON(data)
                
                if let adArray:Array<JSON> = json["T1348647853363"][0]["ads"].array{
                    
                    self.topView.imageURLArray = adArray.map({ (adDic) -> String in
                        
                        if let url = adDic["imgsrc"].string {
                           // print(url)
                            return url
                        }
                        
                        return ""
                        
                    })

                    
                }
                
                if let tempArray:NSArray = json["T1348647853363"].arrayObject{
                    
                    
                        let newsArray = tempArray.subarrayWithRange(NSRange(location: 1, length: (tempArray.count)-1))
                        self.setupTableViewData(newsArray)
                        self.tableVew.tableHeaderView = self.topView
                        self.tableVew.reloadData()
                        

                    
                }

            case .Failure:
                print(Response.result.error)
            }
           
            
           
        }
        
    }
    

    func setupTableViewData(array:NSArray?){
        self.tableviewProtocl = TableviewProtocol()
        self.tableviewProtocl?.newsArray =  array
        
        self.tableVew.delegate = self.tableviewProtocl
        self.tableVew.dataSource = self.tableviewProtocl
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
    
   
    
    
   
    
    func buttonDidClicked(index: Int) {
        print(index)
    }

}

