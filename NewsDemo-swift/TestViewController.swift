//
//  TestViewController.swift
//  NewsDemo-swift
//
//  Created by 黄 家金 on 16/7/22.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit

class TestViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    // MARK: - Property
    var textLabel:UILabel     = UILabel()
    var textButton:UIButton   = UIButton()
    var tableView:UITableView = UITableView()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - viewSetup
    
    func setupNavigationBar(){
        
    }
    
    func addSubviews(){
        
        self.view.addSubview(textLabel)
        self.view.addSubview(textButton)
        self.view.addSubview(tableView)
    }
    
    
    func setupSubviews(){
        
        textButton.enabled = false
        
    }
    
    
    func setupLayout(){
        
        textButton.frame = CGRectMake(0, 0, 20, 20)
        tableView.frame  = CGRectMake(0, 0, 20, 20)
        
    }
    
    // MARK: - private
    
    func getDataFromServer(){
        
    }
    
    func handleData(){
        
    }
    
    // MARK: - Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    

}
