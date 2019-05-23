//
//  ApiTopYesterdayGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ApiFeedBookGateway: FeedBookGateway {
    
}

class ApiFeedBookGatewayImplementation: ApiFeedBookGateway {
    func getRecommend(limit:Int, offset: Int,completetionHandler: @escaping FeedBookCompletionHandler) { apiProvider.request(TSAPI.getRecommend(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    func getTopYesterday(limit:Int, offset: Int, completetionHandler: @escaping FeedBookCompletionHandler) { apiProvider.request(TSAPI.getTopYesterday(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    func getNewRelease(limit:Int, offset: Int, completetionHandler: @escaping FeedBookCompletionHandler) { apiProvider.request(TSAPI.getNewRelease(limit, offset)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    func search(keyword: String, completetionHandler: @escaping FeedBookCompletionHandler) { apiProvider.request(TSAPI.search(keyword)).asObservable().mapObject(FeedBookEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    
    
}
