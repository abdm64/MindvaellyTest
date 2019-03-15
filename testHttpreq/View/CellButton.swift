//
//  CellButton.swift
//  testHttpreq
//
//  Created by ABD on 14/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import UIKit

class CellButton: UIButton {

   
        
        var url : String = ""
    
        
        convenience init(url: String) {
            self.init()
            self.url = url
            
        }
    

}
