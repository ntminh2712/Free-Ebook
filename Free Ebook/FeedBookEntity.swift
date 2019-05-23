//
//  FeedBookEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class FeedBookEntity: NSObject, Mappable{
    var status: Int?
    var code: Int?
    var message: String?
    var result: FeedBookResultEntity?
    var _result: [FeedBookDataEntity] = []
    var dataFeedBook: FeedBookDataEntity?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
        _result <- map["result"]
        dataFeedBook <- map["result"]
    }
}
