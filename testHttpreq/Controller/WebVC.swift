//
//  WebVCViewController.swift
//  testHttpreq
//
//  Created by ABD on 15/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit

class WebVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadWebdata(url: "https://www.example.com/document.pdf")
    }
    func loadWebdata(url: String){
        
        guard let urlTarget  = URL(string: url) else {return}
        let request = URLRequest(url: urlTarget)
        
        webView.loadRequest(request)
        
        
        
        
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
