//
//  APIconnection.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import Foundation

// to connect API and process the json data
class APIconnection{
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var catagory: String!
    var ParsedData = [DataModel]()
    // format json data
    struct JsonData: Decodable{
        let title:String
        let rows: [JsonRows]
        enum CodingKeys : String, CodingKey{
            case title = "title"
            case rows = "rows"
        }
    }
    struct JsonRows:Decodable {
        let subTitle: String
        let description:String
        let imageHref:URL?
        
        enum CodingKeys : String, CodingKey{
            case subTitle = "title"
            case description = "description"
            case imageHref = "imageHref"
        }
    }

    // get connect with API(json)
    func GetConnect(){
        guard let URLreq = URL(string: BaseURL) else {
            print("Error: cannot create URL")
            return
        }
        var getRequest = URLRequest(url: URLreq)
        getRequest.httpMethod = "GET"
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: getRequest) {
            (data, response, error) in
            guard error == nil else {
                print("Error: Invalid calling!")
                return
            }
            guard let responseData = data else {
                print("Error: Did not receive data")
                return
            }
            guard let receivedData = try? JSONDecoder().decode(JsonData.self, from: responseData) else{
                    print("Could not get JSON from responseData as dictionary")
                    return
                }
            self.catagory = receivedData.title
            for i in receivedData.rows{
                let tempData = DataModel(title: i.subTitle, description: i.description, imageURL: i.imageHref!)
                        self.ParsedData.append(tempData)
                    }
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
