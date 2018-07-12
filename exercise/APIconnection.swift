//
//  APIconnection.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import Foundation
import UIKit

// to connect API and process the json data
class APIconnection{
    var catagory: String!
    var ParsedData = [DataModel]()
    // get connect with API(json)
    func GetConnect(UrlStr:String){
        guard let URLreq = URL(string: UrlStr) else {
            print("Error: cannot create URL")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: URLreq) {
            (data, response, error) in
            guard error == nil else {
                print("Error: Invalid calling!")
                return
            }
            guard let responseData = data else {
                print("Error: Did not receive data")
                return
            }
            // parse json data
            if let value = String(data: responseData, encoding: String.Encoding.ascii) {
               if let json = value.data(using: String.Encoding.utf8) {
                let JsonDic = try? JSONSerialization.jsonObject(with: json, options: [])
                    if let dictionary = JsonDic as? [String: Any] {
                       self.catagory = dictionary["title"] as? String
                       if let arrRows = dictionary["rows"] as? [[String:Any]]{
                        for i in arrRows{
                            let subTitle = self.Filter(tempVal: i["title"])
                            let description = self.Filter(tempVal: i["description"])
                            var imageHref = self.Filter(tempVal: i["imageHref"])
                            let tempData = DataModel(title: subTitle, description: description, image: imageHref)
                            self.ParsedData.append(tempData)
                    }
                }
              }
            }
        }
        }
        task.resume()
    }
    
    // this function to filter the null value in json file
    func Filter(tempVal:Any)->String{
        if tempVal is NSNull{
            return ""
        }else{
            return tempVal as! String
        }
    }
}
