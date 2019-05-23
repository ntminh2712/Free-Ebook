//
//  ChildrenEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class ChildrenEntity: NSObject, Mappable{
    var id: Int?
    var name: String?
    var _description: String?
    var picture: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        _description <- map["description"]
        picture <- map["picture"]
    }
}
