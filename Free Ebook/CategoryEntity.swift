//
//  CategoryEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class CategoryEntity: NSObject, Mappable{
    var status: Int?
    var code: Int?
    var message: String?
    var result: [StoryEntity] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}
