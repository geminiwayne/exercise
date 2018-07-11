//
//  ViewController.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let apiconnection = APIconnection()
    override func viewDidLoad() {
        apiconnection.GetConnect()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

