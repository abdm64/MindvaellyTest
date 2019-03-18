//
//  PhotoCell.swift
//  testHttpreq
//
//  Created by ABD on 11/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit
import SDWebImage


var imageCache: NSCache<AnyObject, AnyObject> = NSCache()

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView:  UIImageView!
    
   
    @IBOutlet weak var cellButton: CellButton!
    //
    
    var idImage : String!
    
 
    
    override func awakeFromNib() {
        setView()
        
    }
    // Message from Developer
    /* here a my function to download image from url */
    
    
    func downloadImage(withUrlString urlString: String) {
       
        
         
        guard let url = URL(string: urlString) else {return}
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.imageView.image = imageFromCache
            
            
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
                    
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                }
                
               
                
            }
        }).resume()
        }
   
    // Message from developer
    /*setup the view of the cell and make it looks better */
    func setView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
        
    }
    }
    
    
    

    
    
    
    

    


