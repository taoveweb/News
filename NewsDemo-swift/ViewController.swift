//
//  ViewController.swift
//  NewsDemo-swift
//
//  Created by 黄 家金 on 16/7/21.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var tableVew = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromServer()
        
        addSubView()
        setupLayout()
        setupSubview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
    
    // MARK: - ViewSetup
    
    func addSubView(){
        
        self.view.addSubview(tableVew)
    }
    
    
    func setupLayout(){
        
        self.tableVew.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
    }
    
    func setupSubview(){
        
        self.tableVew.delegate = self
        self.tableVew.dataSource = self
        self.tableVew.rowHeight = 100
        self.tableVew.registerClass(SnapTableViewCell.self, forCellReuseIdentifier: "SnapTableViewCell")
        
    }
    
    
    // MARK: - private
    
    func getDataFromServer(){
        
        Alamofire.request(Method.GET, "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=goMk9xEaxb9mEwxNwluKjtp8hhzCyTnWn8pPG0WnJOsN4xIDbc6Cnl0HqWawjLtN&size=20&version=12.0&spever=false&net=wifi&lat=&lon=&ts=1469141330&sign=Dje5naF3Y4yJ%2FXg%2BkCR4g2fNxjW3i9KWzopOm1EePRh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore").responseJSON { (Response) in
            print(Response)
        }
        
    }
    
    
    // MASK: - delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SnapTableViewCell = tableVew.dequeueReusableCellWithIdentifier("SnapTableViewCell") as! SnapTableViewCell
        
        cell.titleLabel.text  = "titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle"
        cell.detailLabel.text = "detailllable"
   
        
        return cell
    }


}

