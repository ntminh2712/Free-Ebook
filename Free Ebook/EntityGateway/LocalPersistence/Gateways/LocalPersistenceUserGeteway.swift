//
//  LocalPersistenceUserGeteway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit
import RealmSwift
protocol LocalPersistenceUserGateway {
    func saveStoryDownload(_ story: StoryRealmEntity)
    func getStoryDownload(_ storyId: Int) -> StoryRealmEntity?
    func getAllStoryDownload() -> [StoryRealmEntity]?
    
//    func deteleFavorites(_ storyId:Int)
//    func handlerFavorites(_ storyId:Int)
//    func getAllFavorites() -> [Int]?
}

