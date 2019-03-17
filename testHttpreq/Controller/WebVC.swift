//
//  WebVCViewController.swift
//  testHttpreq
//
//  Created by ABD on 15/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit
import WebKit


class WebVC: UIViewController {

   
    @IBOutlet weak var webView: UIWebView!
    
    var dowloadUrl : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = dowloadUrl else {return}
        

         //loed webView from passed url
        loadWebdata(url: url)
    }
    func loadWebdata(url: String){
        // loed webView from passed url
        guard   let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
        
        
        
        
    }
    

    
    // dismiss the view by tapping the button cancel
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

    


