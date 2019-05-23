//
//  AuthorEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class AuthorEntity: NSObject, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var picture: String?
    @objc dynamic var _description: String?
    @objc dynamic var born_die: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        picture <- map["picture"]
        _description <- map["description"]
        born_die <- map["born_die"]


    }
}
