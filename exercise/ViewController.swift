//
//  ViewController.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var ImageCatch = [UIImage]()
    var ImageUrl:URL!
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let apiconnection = APIconnection()
    @IBOutlet weak var CategoryTitile: UILabel!
    override func viewDidLoad() {
        apiconnection.GetConnect(UrlStr: BaseURL)
        CategoryTitile.text = apiconnection.catagory
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return apiconnection.ParsedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.Name.text = apiconnection.ParsedData[indexPath.item].title
        cell.Image.image = #imageLiteral(resourceName: "imageNotFound")
        ImageUrl = URL(string: apiconnection.ParsedData[indexPath.item].image)
        if ImageCatch.count<indexPath.item{
            if ImageUrl != nil{
                 let task = URLSession.shared.dataTask(with: ImageUrl) {
                  (data, response, error) in
                    DispatchQueue.main.async() {
                        if error != nil{
                         let image: UIImage = UIImage(data: data!)!
                         let height = cell.Image.image?.size.height
                         let width = cell.Image.image?.size.width
                         let ratio = height!/width!
                         let newHeight = cell.Image.bounds.size.height/ratio
                         let newWidth = cell.Image.bounds.size.width/ratio
                         cell.Image.frame.size = CGSize(width: newWidth, height: newHeight)
                         cell.Image.image = image
                    }
                }
             }
                task.resume()
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 500)
    }

}

