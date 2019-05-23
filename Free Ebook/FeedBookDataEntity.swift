//
//  FeedBookDataEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
class FeedBookDataEntity: NSObject, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var no: Int = 0
    @objc dynamic var picture: String?
    @objc dynamic var release_date: String?
    @objc dynamic var title: String?
    @objc dynamic var views: Int = 0
    @objc dynamic var downloads: Int = 0
    @objc dynamic var isDownload:Bool = false
    @objc dynamic var links:[LinksEntity]?
    @objc dynamic var isFavorites: Bool = false
    @objc dynamic var category: StoryEntity?
    @objc dynamic var authors: [AuthorEntity] = []
    @objc dynamic var subjects: [SubjectsEntity] = []
  
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        no <- map["no"]
        picture <- map["picture"]
        title <- map["title"]
        release_date <- map["release_date"]
        views <- map["views"]
        downloads <- map["downloads"]
        category <- map["category"]
        authors <- map["authors"]
        subjects <- map["subjects"]
        links <- map["links"]
    }
    
}
