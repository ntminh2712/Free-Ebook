//
//  ApiCategoryGateway.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ApiCategoryGateway: CategoryGateway {
    
}

class ApiCategoryGatewayImplementation: ApiCategoryGateway
{
    func getCategory(completetionHandler: @escaping CategoryCompletionHandler) {
        apiProvider.request(TSAPI.getCategory()).asObservable().mapObject(CategoryEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError:{(error) in
            completetionHandler(.failure(error))
        })
    }
    
    
}
