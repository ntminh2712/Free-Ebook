//
//  ApiTopAuthor.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ApiTopAuthorGateway: TopAuthorGateway {
    
}

class ApiTopAuthorGatewayImplementation: ApiTopAuthorGateway {
    func getTopAuthor(limit:Int, offset:Int, completetionHandler: @escaping TopAuthorCompletionHandler) {
        apiProvider.request(TSAPI.getTopAuthor(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
}
