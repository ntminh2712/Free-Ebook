//
//  StoryRealmEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/25/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ObjectMapper
class StoryRealmEntity: Object, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var no: Int = 0
    @objc dynamic var picture: String?
    @objc dynamic var release_date: String?
    @objc dynamic var title: String?
    @objc dynamic var views: Int = 0
    @objc dynamic var downloads: Int = 0
    @objc dynamic var isDownLoad: Bool = false
    @objc dynamic var links: String?
    @objc dynamic var isFavorites: Bool = false
    @objc dynamic var category: String?
    @objc dynamic var authors: String?
    @objc dynamic var subjects: String?
    @objc dynamic var authorId: Int = 0
    @objc dynamic var categoryId:Int = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
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
        authorId <- map["authorId"]
        categoryId <- map["categoryId"]
    }
    
}

extension StoryRealmEntity {
    
    class func getStoryDownload(_ storyId: Int) -> StoryRealmEntity? {
        do {
            let realm = RealmConnectorManager.connectDefault()
            return realm?.object(ofType: StoryRealmEntity.self, forPrimaryKey: storyId)
        } catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    
    class func getAllStoryDownload() -> [StoryRealmEntity]? {
        do {
            let realm = RealmConnectorManager.connectDefault()
            return realm!.objects(StoryRealmEntity.self).toArray(ofType: StoryRealmEntity.self)
        } catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    class func saveStoryDownload(_ story: StoryRealmEntity) {
        do {
            let realm = RealmConnectorManager.connectDefault()
            guard realm?.object(ofType: StoryRealmEntity.self, forPrimaryKey: story.id) == nil else {
                return
                
            }
            try realm?.write {
                    realm?.add(story, update: false)
            }
            
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
}
