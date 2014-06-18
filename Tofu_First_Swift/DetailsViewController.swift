//
//  DetailsViewController.swift
//  Tofu_First_Swift
//
//  Created by tofu on 14-6-4.
//  Copyright (c) 2014年 tofu jelly. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    var recevie: NSString!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = self.recevie
        
        var label : UILabel = UILabel(frame:CGRect(x: 60.0, y: 150.0, width: 200.0, height: 80.0))
        label.textColor = UIColor.redColor()
        label.text = self.recevie
        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
