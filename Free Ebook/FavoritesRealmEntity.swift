//
//  FavoritesEntity.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/28/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
class FavoritesRealmEntity: Object, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var author: String?
    @objc dynamic var picture: String?
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
        name <- map["name"]
        author <- map["author"]
        picture <- map["picture"]
        authorId <- map["authorId"]
        categoryId <- map["categoryId"]
    }
}

extension FavoritesRealmEntity {
    class func getListFavorites() -> [FavoritesRealmEntity]? {
        do {
            let realm = RealmConnectorManager.connectDefault()
            return realm!.objects(FavoritesRealmEntity.self).toArray(ofType: FavoritesRealmEntity.self)
        } catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    
    class func addFavorites(_ story: FeedBookDataEntity) {
        do {
            let storyRealm: FavoritesRealmEntity = FavoritesRealmEntity ()
            storyRealm.id = story.id
            if story.authors.count != 0 {
                storyRealm.author = story.authors[0].name
                storyRealm.authorId = story.authors[0].id
            }
            storyRealm.categoryId = (story.category?.id)!
            storyRealm.picture = story.picture
            storyRealm.name = story.title
            let realm = RealmConnectorManager.connectDefault()
            guard realm?.object(ofType: FavoritesRealmEntity.self, forPrimaryKey: storyRealm.id) == nil else { return }
            try realm?.write {
                realm?.add(storyRealm, update: false)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    class func addFavoritesDownload(_ story: StoryRealmEntity){
        do {
            let storyRealm: FavoritesRealmEntity = FavoritesRealmEntity ()
            storyRealm.id = story.id
            storyRealm.author = story.authors
            storyRealm.authorId = story.authorId
            storyRealm.categoryId = story.categoryId
            storyRealm.picture = story.picture
            storyRealm.name = story.title
            let realm = RealmConnectorManager.connectDefault()
            try realm?.write {
                realm?.add(storyRealm, update: false)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    class func deleteFavorites(_ storyId: Int) {
        do {
            let realm = RealmConnectorManager.connectDefault()
            guard let story = realm?.object(ofType: FavoritesRealmEntity.self, forPrimaryKey: storyId) else { return }
            try realm?.write {
                realm?.delete(story)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    class func deleteAllFavorites() {
        do {
            let realm = RealmConnectorManager.connectDefault()
            guard let story = realm?.objects(FavoritesRealmEntity.self) else { return }
            try realm?.write {
                realm?.delete(story)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    
    
}

