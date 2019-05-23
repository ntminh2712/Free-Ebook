//
//  SubjectsEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class SubjectsEntity: NSObject, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
        
    }
}
