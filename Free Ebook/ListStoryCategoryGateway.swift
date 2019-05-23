//
//  ListStoryCategoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
typealias AllListStoryCategoryCompletionHandler = (_ author: Result<FeedBookEntity>) -> Void

protocol AllListStoryCategoryGateway {
    func getListStoryCategory(id:Int,limit:Int, offset: Int,completetionHandler: @escaping AllListStoryCategoryCompletionHandler )
    func getDetailStory(id:Int, completetionHandler: @escaping AllListStoryCategoryCompletionHandler )
    func getSameAuthor(id:Int,limit:Int,completetionHandler: @escaping AllListStoryCategoryCompletionHandler)
    func getSameCategory(id:Int,limit:Int, offset: Int,completetionHandler: @escaping AllListStoryCategoryCompletionHandler)
    func downloadStory(id:Int)
}

