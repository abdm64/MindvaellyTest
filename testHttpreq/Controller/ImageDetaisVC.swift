//
//  ImageDetaisVC.swift
//  testHttpreq
//
//  Created by ABD on 12/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit

class ImageDetaisVC: UIViewController {
    // Mark Outlets
    
    
    @IBOutlet weak var imageView: UIImageView!
    
     var passedImage: UIImage!
    var imageUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedImage != nil {
            imageView.image = passedImage
        } else {
            
            Utilities.alert(title: "Err", message: "error loading photo ")
        }
        
       
       
        
        navigationItem.title = "Photo"
        
        
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ImageDetaisVC : ZoomingViewController
{
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return imageView
    }
}
