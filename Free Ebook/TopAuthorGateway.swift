//
//  TopAuthorGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
typealias TopAuthorCompletionHandler = (_ author: Result<FeedBookEntity>) -> Void

protocol TopAuthorGateway {
    func getTopAuthor(limit:Int, offset:Int,completetionHandler: @escaping TopAuthorCompletionHandler)
}
