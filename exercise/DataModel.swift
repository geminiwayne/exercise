//
//  DataModel.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import Foundation
import UIKit

// json data model
class DataModel{
    var title: String
    var description: String
    var image:String
    init(title:String,description: String,image:String) {
        self.title = title
        self.description = description
        self.image = image
    }
}
