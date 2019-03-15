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

    @IBOutlet weak var webView: WKWebView!
    
    var dowloadUrl : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = dowloadUrl else {return}
        

        // Do any additional setup after loading the view.
        loadWebdata(url: url)
    }
    func loadWebdata(url: String){
        guard   let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        
       webView.load(request)
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

    


