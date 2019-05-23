//
//  ApiListStoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ApiListStoryGateway: ListStoryGateway {
    
}

class ApiListStoryGatewayImplementation: ApiListStoryGateway {
    func getTopMonth(limit:Int, offset: Int ,completetionHandler: @escaping TopAuthorCompletionHandler) {
        apiProvider.request(TSAPI.getTopMonth(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    func getNewRelease(limit:Int, offset: Int ,completetionHandler: @escaping TopAuthorCompletionHandler) {
        apiProvider.request(TSAPI.getNewRelease(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    func getTopAuthor(limit:Int, offset: Int ,completetionHandler: @escaping TopAuthorCompletionHandler) {
        apiProvider.request(TSAPI.getTopAuthor(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
}
