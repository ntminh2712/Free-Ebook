//
//  FeedBookResultEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class FeedBookResultEntity: NSObject, Mappable{
    var total: Int?
    var next_url: String?
    var data: [FeedBookDataEntity] = []
    var _data:[AuthorEntity] = []
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        next_url <- map["next_url"]
        data <- map["data"]
        _data <- map["data"]
       
    }
}
