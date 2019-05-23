//
//  CategoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
typealias CategoryCompletionHandler = (_ category: Result<CategoryEntity>) -> Void

protocol CategoryGateway {
    func getCategory(completetionHandler: @escaping CategoryCompletionHandler)
}
