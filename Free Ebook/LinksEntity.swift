//
//  LinkEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class LinksEntity: NSObject, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var format: String?
    @objc dynamic var url: String?
    @objc dynamic var size: Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        format <- map["format"]
        url <- map["url"]
        size <- map["size"]
        
        
    }
}
