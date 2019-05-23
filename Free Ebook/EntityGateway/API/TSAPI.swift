//
//  TSAPI.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//


import Foundation

enum TSAPI
{
    case getCategory()
    case getTopYesterday(Int,Int)
    case getRecommend(Int,Int)
    case getNewRelease(Int,Int)
    case getSameAuthor(Int,Int)
    case getSameCategory(Int,Int,Int)
    case getTopMonth(Int,Int)
    case getTopAuthor(Int,Int)
    case getDetailBook(Int)
    case search(String)
    case downloadStory(Int)
    
}
 
