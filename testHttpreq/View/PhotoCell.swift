//
//  PhotoCell.swift
//  testHttpreq
//
//  Created by ABD on 11/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit




class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView:  UIImageView!
    
    override func awakeFromNib() {
        setView()
    }
    func downloadImage(withUrlString urlString: String) {
        
        
        let url = URL(string: urlString)!
        
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
                let imageToCache = UIImage(data: data!)
                self.imageView.image = imageToCache
               
                //imageCache.setObject(imageToCache!, forKey: url.absoluteString as AnyObject)
            }
        }).resume()
    }
    
    
    
    
    
    
    
    
    
    
    func setView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
        
    }
    
}
let imageCache = NSCache<AnyObject, AnyObject>()
