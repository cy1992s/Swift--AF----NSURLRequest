//
//  SecondViewController.swift
//  Tofu_First_Swift
//
//  Created by tofu on 14-6-4.
//  Copyright (c) 2014年 tofu jelly. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    //  -"IBOutlet"
    @IBOutlet var tableView : UITableView
    
    //  -"Instance"
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibName, bundle: nibBundle)
    }
    
    
    //  -"Properties"
    //    var items : NSString[] = ["Hello Swift","Click Me","TableView DataSource"];
    var dataSource = NSMutableArray()
    let url = "http://www.baidu.com"
    let cellIdentifier: String = "cell"
    //  -"Function"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.initDataUseAFNetworking()
        //        self.initDataUsedReuqest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        
        // Configure the cell...
        
        let cell : UITableViewCell = tableView!.dequeueReusableCellWithIdentifier(cellIdentifier ,forIndexPath: indexPath!) as UITableViewCell
        cell.textLabel.text = self.dataSource[indexPath!.row] as NSString
        return cell
    }
    
    
    //  - TableView Delegate
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        //取消选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var detail:DetailsViewController = DetailsViewController(nibName:nil, bundle:nil)
        detail.recevie = dataSource[indexPath.row] as NSString
        self.navigationController.pushViewController(detail, animated: true)
        
    }
    
    //swift 调用 AFNetworking类库进行网络请求
    func initDataUseAFNetworking(){
        let manager = AFHTTPRequestOperationManager()
        
        println(url)
        manager.GET(url,
            parameters:nil,
            success:{ (operation:AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("\(responseObject.description)")
                
                var dic = responseObject as NSDictionary
                var array = dic["entities"] as NSArray
                
                for dict :AnyObject in array{
                    self.dataSource.addObject(dict["name"])
                }
                self.tableView.reloadData()
            },
            failure:{(operation:AFHTTPRequestOperation!,error:NSError!) in
                println("error \(error.localizedDescription)")
            })
        
    }
    
    
    //使用 NSURLRequest 进行网络请求
    func initDataUsedReuqest(){
        //创建URL
        var loadUrl = NSURL.URLWithString(url)
        //request请求
        var request = NSURLRequest(URL :loadUrl)
        //创建请求队列
        var queue = NSOperationQueue()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //发起异步请求
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { response, data, error in
                if error {
                    println(error)
                }else{
                    let json = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    let tempDataSource = json["entities"] as NSArray
                    for dict :AnyObject in tempDataSource{
                        self.dataSource.addObject(dict["name"])
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                        })
                }
                })
            })
    }
}
