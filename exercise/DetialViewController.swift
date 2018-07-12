//
//  DetialViewController.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/12.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import UIKit

class DetialViewController: UIViewController {
    var detailDes: String!
    var detailImage:UIImage!
    var detailTitle:String!

    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // lanscape layout(left:right = 3:7)
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            self.ImageView?.translatesAutoresizingMaskIntoConstraints = false
            self.TextView?.translatesAutoresizingMaskIntoConstraints = false
            let ImageHeight = NSLayoutConstraint(item: self.ImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.9, constant: 0)
            let leadMargin = NSLayoutConstraint(item: self.ImageView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10)
            let width = NSLayoutConstraint(item: self.ImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.3, constant: -10)
            
            let widthText = NSLayoutConstraint(item: self.TextView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.7, constant: -10)
            let textLeadMargin = NSLayoutConstraint(item: self.TextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant:0.3*self.view.bounds.size.width)
            let trailingMargin = NSLayoutConstraint(item: self.TextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 10)
            let TextHeight = NSLayoutConstraint(item: self.TextView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.9, constant: 0)
            
            self.view.addConstraints([ImageHeight,leadMargin,width,widthText,textLeadMargin,trailingMargin,TextHeight])
        }
        TextView.text = detailDes
        self.title = detailTitle
        ImageView.image = detailImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
