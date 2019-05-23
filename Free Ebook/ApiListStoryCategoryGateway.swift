//
//  ApiListStoryCategoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ApiListStoryCategoryGateway: AllListStoryCategoryGateway {
    
}

class ApiListStoryCategoryGatewayImplementation: ApiListStoryCategoryGateway {
    func getListStoryCategory(id: Int, limit: Int, offset: Int, completetionHandler: @escaping AllListStoryCategoryCompletionHandler) {
        apiProvider.request(TSAPI.getSameCategory(id,limit,offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    func getDetailStory(id: Int, completetionHandler: @escaping AllListStoryCategoryCompletionHandler) {
        apiProvider.request(TSAPI.getDetailBook(id)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    func getSameAuthor(id: Int, limit: Int, completetionHandler: @escaping AllListStoryCategoryCompletionHandler) {
        apiProvider.request(TSAPI.getSameAuthor(id,limit)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    func getSameCategory(id: Int, limit: Int, offset:Int ,completetionHandler: @escaping AllListStoryCategoryCompletionHandler) {
        apiProvider.request(TSAPI.getSameCategory(id,limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    func downloadStory(id:Int) {
         apiProvider.request(TSAPI.downloadStory(id)).asObservable()
    }
}
