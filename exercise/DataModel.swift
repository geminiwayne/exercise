//
//  DataModel.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import Foundation

// json data model
class DataModel{
    var title: String
    var description: String
    var imageURL: String
    init(title:String,description: String,imageURL:String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
