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
import SDWebImage





class PhotosVC : UIViewController {
    // Outltes
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //  Var
    
    
    var isLoading: Bool = false
    var photoThumbnail: UIImage!
    var selectedIndexPath: IndexPath!
    var alertIndexPath : IndexPath!
    var urlPassedToWebVC : String!
    let mystoryboard =  MYStoryboard()
    let refresh = UIRefreshControl()
    let imageHolder = UIImage(named: "PlaceHolder-1")
    var photoArray = [Photo]()
    var photoArrayTest = [Photo]()

   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // call the func retruveDatafromUrl(url: BASE_URL) using the  BASE_URL (the url send it to me via email)
       self.retruveDatafromUrl(url: BASE_URL)
        
        /*in all the networking operation we expected  some delay in case internet connection slow or somthing so i add DispatchQueue.main.asyncAfter(deadline: .now() + 1) to ensure that all data was downloaded and make smooth user experience */
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.activityIndicator.stopAnimating()
             self.collectionView.reloadData()
            
            
        }
        // add func pullTorefresh action to our view
        self.pullTorefresh()
       // setup the delegate
        if collectionView != nil {
            if let layout = collectionView.collectionViewLayout as? PinterestLayout {
                layout.delegate = self
            }
            // update the UI
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
    }
    //Mark UI
    @objc func refreshView(){
       // we use refreshView func to relead for our collectionView and get more data from internet ("our url")
        self.retruveDatafromUrl(url: BASE_URL)
         self.collectionView.reloadData()
       
        refresh.endRefreshing()
    }
    func pullTorefresh(){
         //add Pull to referesh action to our collectionView
        refresh.tintColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 1)
        if collectionView != nil {
            self.collectionView.alwaysBounceVertical = true
            // we use refreshView func to relead for our collectionView and get more data from internet ("our url")
            refresh.addTarget(self, action: #selector(self.refreshView), for: .valueChanged)
            
            self.collectionView.addSubview(refresh)

        }
            }
    
   
    
    func retruveDatafromUrl(url : String) {
        
        // this func allow us retrive the Json data from the url
             let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
                    guard let data = data else {return}
            do {
                    let jsonData = try JSON(data : data)
                // in this step we take the data retrive from the given url and put in array of Photo by using our good friend SwiftyJSON
                for i in 0...jsonData.count {
                    // fill our photoArray with the needed type of data:  url id ....
                    self.retrivePhotoData(i: i, jsonData: jsonData)
                    
                }
                
                
                
                  
        
            } catch  {
                print(error)
                
            }
        
                }.resume()
        
        
    }
    func retrivePhotoData(i: Int, jsonData : JSON){
        // Message from developer
        /* i used SWiftyJSON to deal with  the url because SwiftyJSON is powerful tools to deal with JSON  so no need to safe unrrwap for the value because swiftyjson is already  done taht for us */
        let id = jsonData[i]["id"].stringValue
        let rowUrl = jsonData[i]["urls"]["raw"].stringValue
        let fullUrl  = jsonData[i]["urls"]["full"].stringValue
        let regularUrl = jsonData[i]["urls"]["regular"].stringValue
        let smallUrl = jsonData[i]["urls"]["small"].stringValue
        let thumbUrl =  jsonData[i]["urls"]["thumb"].stringValue
        let height = jsonData[i]["height"].intValue
        // after get the data from the url  we save it in array from photo to use it later to download image from the web
        let url = Photo(id: id, raw: rowUrl, full: fullUrl, regular: regularUrl, small: smallUrl, thumb: thumbUrl, height: height)
        // save it to the array
        
        self.photoArray.append(url)
    
      
        
    }
    @objc func takeAction(sender : UIButton){
        
       //take the sender.tag witch is btw the indexPath.row of the selected cell
        self.showAlert(num: sender.tag)
    }
    func showAlert(num : Int){
        /*convert the sender.tag to indexPath to identif the selected cell */
        let indexPath = IndexPath(row: num, section: 0)
        /*create the selected cell an cast it as PhotoCell witch it is our  custum view for the cell and pass the indexPath we created early*/
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        /* create alert to preforme more than action for the photo you can notice that the style of the alert is .actionSheet ,
         this exactly what we need .*/
        let alert = UIAlertController(title: "preform action for the photo ", message: "we can preforem action for the photo", preferredStyle: .actionSheet)
        // Add Cancel download action
        let cancelDownloadAction = UIAlertAction(title: "Cancel Download", style: .default) { (action) in
            
            if  cell.imageView.image == self.imageHolder {
                //message for the user  presented by AlertView
                Utilities.alert(title: "err", message:" is already canceled")
            } else {
                cell.imageView.image = self.imageHolder
            }
          
            
        }
         // Add resume  download action
        let resumeDownloadAction = UIAlertAction(title: "Resume Download", style: .default) { (action) in
            
            if  cell.imageView.image == self.imageHolder {
                 cell.imageView.sd_setImage(with:URL(string: self.photoArray[indexPath.item].regular ), placeholderImage:  nil, options: [.cacheMemoryOnly, .progressiveDownload], completed: nil)
            } else {
                //message for the user  presented by AlertView
                Utilities.alert(title: "err", message:" is already downloaded")
            }
            
            
        }
        // Add open the link in the web action
        let downloadInWebViewAction = UIAlertAction(title: "Open in the web", style: .default) { (action) in
            // Message from developer
            /*this action allow us to open the url in web in case the url is for a pdf or zip file  in it */
            self.urlPassedToWebVC = self.photoArray[indexPath.row].full
            
            // preforme the segue to move to webViewVC
            self.performSegue(withIdentifier: self.mystoryboard.segueToWebVC, sender: nil)
            
            
        }
        // to dismiss the alert
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //Add the actions to alert
        alert.addAction(cancelDownloadAction)
        alert.addAction(resumeDownloadAction)
        alert.addAction(downloadInWebViewAction)
        alert.addAction(cancel)
        //support ipad AlertSheet to presented center of the ipad screen you can check the function in Utilities file
        addActionSheetForiPad(actionSheet: alert)
         //present Alert View to the user
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Configure the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass the data between the VC using the segue
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
        // Message from developer
        // in this func we need the height of the cell so we can use ou PhotoArray to get the height of the photo ; and because the height of the full reselution of the photo is so big we multiply the height of the photo we get to The factor 0.2 to make our user expirence smooth factor = 0.2
        let height : CGFloat = CGFloat(photoArray[indexPath.item].height)
        // Messege from developer
        
        /* i use Pinterestlayout from the wonderful raywenderlich team  and  i do  little bit of change  to support ipad ( 4 columns in ipad instad of 2 culums on iphone devices by using the class DeviceType; you can check my modificationn in line  45 in Pinterestlayout file  */
        // end of message
    
        return height * 0.2
    }
    
    
    
    
    
    
    
    
}
// Mark : DataSource

extension  PhotosVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of items In  section  determined by the  number of element in the photoArray
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mystoryboard.photoCell, for: indexPath) as! PhotoCell
        
        if cell.imageView.image == imageHolder {
            cell.imageView.image = imageHolder
        } else {
              cell.imageView.sd_setImage(with:URL(string: photoArray[indexPath.item].regular ), placeholderImage:  nil, options: [.cacheMemoryOnly, .progressiveDownload], completed: nil)
        }
        /* you can notice i used SDWebImage as default image downloader because it's so simple and efficase to download image from internet but i can use my downloader image extention for exemple : */
      // DOWNLOAD IMAGE WITHOUT SDWEBimage
      //cell.imageView.downloadImage(withUrlString:photoArray[indexPath.item].regular )
        
        // deal with the button on the cell by saving the tag of the button
    
        cell.cellButton.tag = indexPath.row
        // add the action to the button in the cell
        cell.cellButton.addTarget(self, action: #selector(self.takeAction), for: .touchUpInside)
        // Message from developer
        /*the takeAction func is func allow us take action for the selected cell ,action like cancel download or resume dowload presented by UIAlertView (type of sheetAlerView)  we can choose the right selected cell by passing the sender.tag witch is BTW is our needed indexPath.row */
        
        
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
      let cell = collectionView.cellForItem(at:  indexPath) as! PhotoCell
        
        self.photoThumbnail = cell.imageView.image
        
        self.selectedIndexPath = indexPath
        
// Message from developer
        /*i use segue to pass data between the two VC because is not a big project when i need to use notification observer */
        
    
        performSegue(withIdentifier: mystoryboard.segueToPhotoVC, sender: photoThumbnail)
    }

    
    
    
    
    
    
}

extension PhotosVC : ZoomingViewController {
    // Message from developer
    /* i found  "ZoomTransitioningDelegate" on github created by Duc Tran  the class allow us to add a cool animation between our UICollectionView and PhotoVC simple to use "big thanks to Duc Tran"  */
    
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

