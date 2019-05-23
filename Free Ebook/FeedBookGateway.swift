//
//  TopYesterdayGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
typealias FeedBookCompletionHandler = (_ category: Result<FeedBookEntity>) -> Void

protocol FeedBookGateway {
    func getTopYesterday(limit:Int, offset:Int ,completetionHandler: @escaping FeedBookCompletionHandler)
    func getNewRelease(limit:Int, offset:Int ,completetionHandler: @escaping FeedBookCompletionHandler)
    func getRecommend(limit:Int, offset:Int ,completetionHandler: @escaping FeedBookCompletionHandler)
    func search(keyword:String ,completetionHandler: @escaping FeedBookCompletionHandler)
}
