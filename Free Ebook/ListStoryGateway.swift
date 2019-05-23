//
//  ListStoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
typealias ListStoryCompletionHandler = (_ author: Result<FeedBookEntity>) -> Void

protocol ListStoryGateway {
    func getTopAuthor(limit:Int, offset:Int ,completetionHandler: @escaping TopAuthorCompletionHandler)
    func getTopMonth(limit:Int, offset:Int ,completetionHandler: @escaping TopAuthorCompletionHandler)
    func getNewRelease(limit:Int, offset:Int ,completetionHandler: @escaping TopAuthorCompletionHandler)
}

