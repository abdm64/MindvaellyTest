//
//  Tools.swift
//  testHttpreq
//
//  Created by ABD on 12/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import Foundation
import UIKit

struct Utilities {
    
    
    static func alert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
}
}
