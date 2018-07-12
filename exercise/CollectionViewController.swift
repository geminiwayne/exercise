//
//  CollectionViewController.swift
//  exercise
//
//  Created by Dong Wang on 2018/7/12.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import UIKit
import os

private let reuseIdentifier = "CollectionCell"

class CollectionViewController: UICollectionViewController {
    var ImageCatch = [Bool]()
    var ImageUrl:URL!
    var refresher:UIRefreshControl!
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let apiconnection = APIconnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiconnection.GetConnect(UrlStr: BaseURL)
        ImageShowMonitor()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        refresher.addTarget(self, action: #selector(CollectionViewController.getFreser), for: UIControlEvents.valueChanged)
        self.collectionView!.refreshControl = refresher
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // refresh function 
    @objc func getFreser(){
        if apiconnection.ParsedData.count>0{
            ImageShowMonitor()
            collectionView?.reloadData()
        }else{
            refresher.attributedTitle = NSAttributedString(string: "No new data!")
        }
        refresher.endRefreshing()
        
    }
    
      // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return apiconnection.ParsedData.count
    }

    // show collection view and resize the view based on image size
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.Name.text = apiconnection.ParsedData[indexPath.item].title
        cell.Name.textAlignment = .center
        cell.Image.image = #imageLiteral(resourceName: "imageNotFound")
        if ImageCatch[indexPath.item] == false{
            if apiconnection.ParsedData[indexPath.item].image != ""{
                ImageUrl = URL(string: apiconnection.ParsedData[indexPath.item].image)
                let task = URLSession.shared.dataTask(with: ImageUrl) {
                    (data, response, error) in
                    DispatchQueue.main.async() {
                        if error == nil {
                            if UIImage(data:data!) != nil{
                                let image: UIImage = UIImage(data: data!)!
                                let height = cell.Image.image?.size.height
                                let width = cell.Image.image?.size.width
                                let ratio = height!/width!
                                let newHeight = cell.Image.bounds.size.height/ratio
                                let newWidth = cell.Image.bounds.size.width/ratio
                                cell.Image.frame.size = CGSize(width: newWidth, height: newHeight)
                                cell.Image.image = image
                                let newCellHeight = cell.Name.bounds.size.height + newHeight
                                cell.bounds.size = CGSize(width: newWidth, height: newCellHeight)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
        return cell
    }
    
    // monitor the image to load
    func ImageShowMonitor(){
        if apiconnection.ParsedData.count != 0{
            self.title = apiconnection.catagory
            for i in 0...(apiconnection.ParsedData.count-1){
                ImageCatch.append(false)
            }
        }
    }
    
    // pass value to detailviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //      Get the new view controller using segue.destinationViewController.
        //      Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? ""){
        case"ShowDetail":
            os_log("Show Details.", log: OSLog.default, type: .debug)
            guard let detailViewController = segue.destination as? DetialViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? CollectionViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = collectionView?.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            detailViewController.detailTitle = apiconnection.ParsedData[indexPath.row].title
            detailViewController.detailImage = selectedCell.Image.image
            detailViewController.detailDes = apiconnection.ParsedData[indexPath.row].description
        default:
            print("Can't find the identifer")
            break
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
