////
////  Epub.swift
////  Free Ebook
////
////  Created by MinhNT-Mac on 1/29/19.
////  Copyright © 2019 MinhNT-Mac. All rights reserved.
////
//
//import Foundation
//
//enum Epub: Int {
//    case bookOne = 0
//    case bookTwo
//    
//    var name: String {
//        switch self {
//        case .bookOne:      return "The Silver Chair" // standard eBook
//        case .bookTwo:      return "pg25568-images" // audio-eBook
//        }
//    }
//    
//    var shouldHideNavigationOnTap: Bool {
//        switch self {
//        case .bookOne:      return false
//        case .bookTwo:      return true
//        }
//    }
//    
//    var scrollDirection: FolioReaderScrollDirection {
//        switch self {
//        case .bookOne:      return .vertical
//        case .bookTwo:      return .horizontal
//        }
//    }
//    
//    var bookPath: String? {
//        return Bundle.main.path(forResource: self.name, ofType: "epub")
//    }
//    
//    var readerIdentifier: String {
//        switch self {
//        case .bookOne:      return "READER_ONE"
//        case .bookTwo:      return "READER_TWO"
//        }
//    }
//}
