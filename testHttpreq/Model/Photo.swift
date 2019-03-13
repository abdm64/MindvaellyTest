//
//  Model.swift
//  testHttpreq
//
//  Created by ABD on 10/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import Foundation


//typealias Photos = [Photo]

struct Photo {
    public private(set)  var id: String
    public private(set)  var raw: String
    public private(set) var full: String
    public private(set) var regular: String
    public private(set) var small: String
    public private(set) var thumb: String
     public private(set) var  height : Int

}
//struct Photo {
//    public private(set)  var id: String
//    public private(set)var urls: Urls
//}

enum URLS {
    case raw, full, regular, small, thumb
}
