//
//  ViewController.swift
//  Tofu_First_Swift
//
//  Created by tofu on 14-6-4.
//  Copyright (c) 2014年 tofu jelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBAction func click(sender : UIButton) {
        
        println("点击！！！ \(sender.tag)");
        var second:SecondViewController = SecondViewController(nibName:"SecondViewController" ,bundle:nil)
        self.navigationController.pushViewController(second, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
    }
    
    
    func initViews(){
        var label: UILabel = UILabel()
        label.frame = CGRect(x:60, y:400, width:200, height:100)
        label.font = UIFont.boldSystemFontOfSize(18)
        label.text = "这是code"
        label.textColor = UIColor.redColor()
        label.backgroundColor = UIColor.grayColor()
        self.view.addSubview(label)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

