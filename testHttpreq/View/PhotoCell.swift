//
//  PhotoCell.swift
//  testHttpreq
//
//  Created by ABD on 11/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit
import SDWebImage




class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView:  UIImageView!
    
   
    @IBOutlet weak var cellButton: CellButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
 
    var canceled = false
    
    override func awakeFromNib() {
        setView()
        
    }
    
    
    
    func downloadImage(withUrlString urlString: String) {
        spinner.style = .whiteLarge
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
         canceled = true
        guard let url = URL(string: urlString) else {return}
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.imageView.image = imageFromCache
             self.spinner.stopAnimating()
            
            return
        }
       
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                debugPrint(String(describing: error?.localizedDescription))
                return
            }
            
            DispatchQueue.main.async {
                if  let imageToCache = UIImage(data: data!) {
                    self.imageView.image = imageToCache
                    self.spinner.stopAnimating()
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                }
                
               
                
            }
        }).resume()
        }
    func cancalDownloadImage(url : String ){
        
        guard let url = URL(string: url) else {return}
        
        print("imageDownload canceld ", url)
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                debugPrint(String(describing: error?.localizedDescription))
                return
            }
            
            DispatchQueue.main.async {
                if  let imageToCache = UIImage(data: data!) {
                    self.imageView.image = imageToCache
                    self.spinner.stopAnimating()
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                }
                
                
                
            }
        }).cancel()
        
        }
    func setView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
        
    }
    }
    
    
    
    
    
    
    
    
    
    

    

var imageCache: NSCache<AnyObject, AnyObject> = NSCache()
