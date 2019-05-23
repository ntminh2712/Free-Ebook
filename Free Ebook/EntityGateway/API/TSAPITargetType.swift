//
//  TSAPI.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation


import UIKit
import Moya
import RxSwift
extension TSAPI:TargetType
{
    var baseURL: URL {
        return URL(string: Config.rootUrl)!
    }
    
    var path: String {
        switch self {
        case .getCategory:
            return "/category/list"
        case .getTopYesterday:
            return "/book/top-yesterday"
        case .getRecommend:
            return "/book/recommend"
        case .getNewRelease:
            return "/book/new-release"
        case .getSameAuthor:
            return "/book/same-author"
        case .getSameCategory:
            return "/book/same-category"
        case .getTopAuthor:
            return "/author/top"
        case .getTopMonth:
            return "/book/top-month"
        case .getDetailBook:
            return "/book/detail"
        case .search:
            return "/book/search"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategory, .getTopYesterday, .getDetailBook, .getNewRelease, .getRecommend, .getSameAuthor, .getSameCategory, .getTopAuthor, .getTopMonth, .search:
            return .get
        case .downloadStory:
            return .post
        default:
            return .get
        }
    }
    
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .getCategory, .getTopYesterday, .getDetailBook, .getNewRelease, .getRecommend, .getSameAuthor, .getSameCategory, .getTopAuthor, .getTopMonth, .search:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    
    var sampleData: Data {
        switch self {
        default:
            guard let url = Bundle.main.url(forResource: "Demo", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    public var parameters: [String : Any]? {
        switch self {
          
        case .getSameAuthor(let id, let limit):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["id"] = id
                parameter["limit"] = limit
                return parameter
            }
            return paramester
        case .getSameCategory(let id, let limit, let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["id"] = id
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
        case .getTopAuthor(let limit ,let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
        case .getRecommend(let limit,let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
        case .getTopYesterday(let limit,let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
        case .getNewRelease(let limit,let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
            
        case .getTopMonth(let limit,let offset):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["limit"] = limit
                parameter["offset"] = offset
                return parameter
            }
            return paramester
        case .getDetailBook(let id):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["id"] = id
                return parameter
            }
            return paramester
        case .search(let keyword):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["keyword"] = keyword
                parameter["limit"] = 20
                return parameter
            }
            return paramester
        case .downloadStory(let id):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["id"] = id
                return parameter
            }
            return paramester
        default:
            return [:]
        }
    }
    var task: Moya.Task {
        return .requestParameters(parameters: self.parameters! , encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        let token = "h8T0DF9yqGKqEooDaoCkAaBL_WVjhm36"
        switch self {
        case  .downloadStory, .getCategory, .getTopYesterday, .getDetailBook, .getNewRelease, .getRecommend, .getSameAuthor, .getSameCategory, .getTopAuthor, .getTopMonth, .search:
            var header: [String:String]?{
                var header: [String:String] = [:]
                header["Authorization"] = "Bearer \(token)"
                return header
            }
            return header
        default:
            return [:]
        }
        return [:]
    }
    
    
    
}

