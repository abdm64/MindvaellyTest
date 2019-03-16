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
    
    
    var isLoading: Bool = false
    var photoThumbnail: UIImage!
    var selectedIndexPath: IndexPath!
    var alertIndexPath : IndexPath!
    var urlPassedToWebVC : String!
    let mystoryboard =  MYStoryboard()
    let refresh = UIRefreshControl()
    let iamgeHolder = UIImage(named: "PlaceHolder-1")
    
    
   
    
    
    
    
    
    
  
   
    var photoArray = [Photo]()

   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.retruveDatafromUrl(url: BASE_URL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.activityIndicator.stopAnimating()
             self.collectionView.reloadData()
            
        }
        self.pullTorefresh()
       // setup the delegate
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
       // update the UI
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    //Mark UI
    @objc func refreshView(){
        print("refresh")
        self.retruveDatafromUrl(url: BASE_URL)
         self.collectionView.reloadData()
        //self.removeEmptyCell()
        refresh.endRefreshing()
    }
    func pullTorefresh(){
        refresh.tintColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 1)
        self.collectionView.alwaysBounceVertical = true
        refresh.addTarget(self, action: #selector(self.refreshView), for: .valueChanged)
        self.collectionView.addSubview(refresh)
    }
    func removeEmptyCell(){
       // let cell = self.collectionView.cellForItem(at: [2,0]) as! PhotoCell
        let indexPath = IndexPath(row: 2, section: 0)
        self.collectionView.deleteItems(at: [indexPath])
    }
    
    
    func retruveDatafromUrl(url : String) {
        
        
             let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
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
        // Message from developer
        /* i used SWiftyJSON to to ubstract the url because SwiftyJSON make our life a lot easer so no need to safe unrrwap for the value because swiftyjson do taht for us */
        let id = jsonData[i]["id"].stringValue
        let rowUrl = jsonData[i]["urls"]["raw"].stringValue
        let fullUrl  = jsonData[i]["urls"]["full"].stringValue
        let regularUrl = jsonData[i]["urls"]["regular"].stringValue
        let smallUrl = jsonData[i]["urls"]["small"].stringValue
        let thumbUrl =  jsonData[i]["urls"]["thumb"].stringValue
        let height = jsonData[i]["height"].intValue
        // after get the data we need from url we save it in array from photo to use it later to download image from the web 
        let url = Photo(id: id, raw: rowUrl, full: fullUrl, regular: regularUrl, small: smallUrl, thumb: thumbUrl, height: height)
        
        
        self.photoArray.append(url)
    
      
        
    }
    @objc func takeAction(sender : UIButton){
        print(sender.tag)
       //
        self.showAlert(num: sender.tag)
    }
    func showAlert(num : Int){
        let indexPath = IndexPath(row: num, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        
        let alert = UIAlertController(title: "preform action for the url", message: "we can preforem action for the photo", preferredStyle: .actionSheet)
        let cancelDownloadAction = UIAlertAction(title: "cancel download", style: .default) { (action) in
            cell.imageView.image = UIImage(named: "PlaceHolder-1")
          
            
        }
        
        let downloadInWebViewAction = UIAlertAction(title: "Open in the web", style: .default) { (action) in
            self.urlPassedToWebVC = self.photoArray[indexPath.row].full
            
            self.performSegue(withIdentifier: "ToWebVC", sender: nil)
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelDownloadAction)
        alert.addAction(downloadInWebViewAction)
        alert.addAction(cancel)
       UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
        
    }
    
    //Prepare for SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier ==  mystoryboard.segueToPhotoVC {
        
            let imagedetailVC = segue.destination as! ImageDetaisVC
            let backItem = UIBarButtonItem()
            backItem.title = "Photos"
            navigationItem.backBarButtonItem = backItem
            imagedetailVC.passedImage = photoThumbnail
            
            
        }
        if segue.identifier == mystoryboard.segueToWebVC {
            let webVC = segue.destination as! WebVC
            webVC.dowloadUrl = urlPassedToWebVC
            
        }
    }
    
   
    
        
    }
// Mark Flow layout Deleget

extension PhotosVC : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height : CGFloat = CGFloat(photoArray[indexPath.item].height)
        // Messege from developer
        
        /* i use Pinterestlayout from the wanderfull ray wendlich and do a change a little bit of code to support ipad ( 4 columnt in ipad instad of 2 culumt on iphone devices by using the class DeviceType you can check my modificationn i do som mark*/
        // end of message
    
        return height * 0.2
    }
    
    
    
    
    
    
    
    
}
// Mark : DataSource

extension  PhotosVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mystoryboard.photoCell, for: indexPath) as! PhotoCell
        
        if cell.imageView.image == iamgeHolder {
            cell.imageView.image = iamgeHolder
        } else {
              cell.imageView.sd_setImage(with:URL(string: photoArray[indexPath.item].regular ), placeholderImage:  nil, options: [.cacheMemoryOnly, .progressiveDownload], completed: nil)
        }
      
      // cell.downloadImage(withUrlString: photoArray[indexPath.item].full)
    
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

