//
//  PhotosVC.swift
//  testHttpreq
//
//  Created by ABD on 09/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDDownloadManager
import SDWebImage





class PhotosVC : UIViewController {
    // Mark : Outltes
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Mark : Var
    
    let images = [#imageLiteral(resourceName: "image2"),#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image8"),#imageLiteral(resourceName: "image4"),#imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image6")]
    var isLoading: Bool = false
    var photoThumbnail: UIImage!
    var selectedIndexPath: IndexPath!
    var alertIndexPath : IndexPath!
    
    
    
    
    
  
   
    var photoArray = [Photo]()

   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.retruveDatafromUrl(url: BASE_URL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
             self.collectionView.reloadData()
            
        }
       
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    //Mark UI
    
    
    
    func retruveDatafromUrl(url : String) {
        
        
             let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
                self.isLoading = true
                    guard let data = data else {return}
            do {
                    let jsonData = try JSON(data : data)
                for i in 0...jsonData.count {
                    
                    self.retrivePhotoData(i: i, jsonData: jsonData)
                    
                }
                
                
                
                  
        
            } catch  {
                print(error)
                
            }
        
                }.resume()
         self.isLoading = false
        
    }
    func retrivePhotoData(i: Int, jsonData : JSON){
        let id = jsonData[i]["id"].stringValue
        let rowUrl = jsonData[i]["urls"]["raw"].stringValue
        let fullUrl  = jsonData[i]["urls"]["full"].stringValue
        let regularUrl = jsonData[i]["urls"]["regular"].stringValue
        let smallUrl = jsonData[i]["urls"]["small"].stringValue
        let thumbUrl =  jsonData[i]["urls"]["thumb"].stringValue
        let height = jsonData[i]["height"].intValue
        
        let url = Photo(id: id, raw: rowUrl, full: fullUrl, regular: regularUrl, small: smallUrl, thumb: thumbUrl, height: height)
        
        
        self.photoArray.append(url)
    
      
        
    }
    @objc func takeAction(sender : UIButton){
        print(sender.tag)
       //
        self.showAlert(num: sender.tag)
    }
    func showAlert(num : Int){
        let alert = UIAlertController(title: "preform action for the url", message: "we can preforem action for the photo", preferredStyle: .actionSheet)
        let cancelDownloadAction = UIAlertAction(title: "Cancel download", style: .default) { (action) in
            print("donload canceld")
            
            // cancel dowload image
            let indexPath = IndexPath(row: num, section: 0)
            
            let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
            cell.cancalDownloadImage(url: self.photoArray[indexPath.row].regular)
            print(self.photoArray[indexPath.row].full)
            
        }
        let downloadInWebViewAction = UIAlertAction(title: "Download in the web", style: .default) { (action) in
            print("open in the web")
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelDownloadAction)
        alert.addAction(downloadInWebViewAction)
        alert.addAction(cancel)
       UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier ==  SHOW_IMAGE_SEGUE {
        
            let imagedetailVC = segue.destination as! ImageDetaisVC
            let backItem = UIBarButtonItem()
            backItem.title = "Photos"
            navigationItem.backBarButtonItem = backItem
            imagedetailVC.passedImage = photoThumbnail
            
            
        }
    }

   
    
        
    }
// Mark Flow layout Deleget

extension PhotosVC : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height : CGFloat = CGFloat(photoArray[indexPath.item].height)
    
        return height * 0.2
    }
    
    
    
    
    
    
    
    
}
// Mark : DataSource

extension  PhotosVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHOTO_CELL, for: indexPath) as! PhotoCell
       
       cell.downloadImage(withUrlString: photoArray[indexPath.item].regular)
        cell.cellButton.tag = indexPath.item
        cell.cellButton.addTarget(self, action: #selector(self.takeAction), for: .touchUpInside)
        
        
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
      let cell = collectionView.cellForItem(at:  indexPath) as! PhotoCell
        
        self.photoThumbnail = cell.imageView.image
        
        self.selectedIndexPath = indexPath
        

    
        performSegue(withIdentifier: SHOW_IMAGE_SEGUE, sender: photoThumbnail)
    }
    
    
    
    
    
    
    
}

extension PhotosVC : ZoomingViewController {
    
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: indexPath) as! PhotoCell
            
            return cell.imageView
        }
        
        return nil
    }

    
}

