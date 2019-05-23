//
//  Define.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
struct SegueIdentifier {
    //Explore
    static let goPlayLitsController = "goPlayLitsController"
    static let goListStory = "goListStory"
}

struct ControllerIdentifier {
    //Login
    static let navigationLogin = "navigationLogin"
    
}
struct DateFormat {
    static let yyyyssDash = "yyyy-MM-dd'T'HH:mm:ss"
    static let ddmmSlash = "dd/MM/yyyy HH:mm"
    static let ddMMyyyy = "dd/MM/yyyy"
    static let MMyyyy = "MM/yyyy"
    static let yyyyMMdd = "yyyy/MM/dd"
    static let yyyymsDash = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    static let yyyymsZDash = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let HHmm = "HH:mm"
    static let slashddmmyy = "HH:mm dd/MM/yyyy"
    static let yyyymdHmsZ = "yyyy-MM-dd HH:mm:ss ZZZ"
    static let yyyyMdHms = "yyyy/MM/dd HH:mm:ss"
    static let ddMMMMyyyy = "dd MMMM','yyyy"
    static let yyyyMMddHHmmss = "yyyyMMddHHmmss"
}

struct Category {
    static let NewRelease:Int = 1
    static let TopMonth:Int = 2
    static let ViewAllTopYesterday:Int = 3
    static let ViewAllNewRelease:Int = 4
    static let ViewAllRecommend:Int = 5
    static let SubCategory: Int = 6
    static let ViewAllFormAuthor: Int = 7
    static let ViewAllSameAuthor:Int = 8
    static let ViewAllSameCategory:Int = 9
}

enum notificationName: String {
    //Login
    case home = "home"
    case myLibrary = "myLibrary"
    case downloadSuccess = "downloadSuccess"
    case updateProgress = "updateProgress"
    var notification: NSNotification.Name{
        return Notification.Name(rawValue: self.rawValue)
    }
}
struct Admod {
    static let banner = "ca-app-pub-3646407986539386/7164932517"
    static let interstitial =  "ca-app-pub-3646407986539386/4666761685"
    static let id = "ca-app-pub-3646407986539386~1142325930"
    static let Rewarded = "ca-app-pub-3646407986539386/6718209950"
}
struct SocialNetWorking {
    static let linkDownLoadApp = ""
    static let contentShare = ""
    static let emailKolorFox = "kolorfoxstudio@gmail.com"
}

struct TitleAlert {
    static let success = "Success !"
    static let error = "Error !"
    static let message = "Message !"
    static let _continue = "Continue"
    static let  _cancel = "Cancel"
    static let unavilable = "Unavilable !"
    static let ok = "Ok"
}

enum segmented{
    static let AllStory:Int = 0
    static let SubCategory: Int = 1
}

struct Format {
    public static var FORMAT_HTML = "FORMAT_HTML"
    public static var FORMAT_EPUB_IMAGE = "FORMAT_EPUB_IMAGE"
    public static var FORMAT_EPUB = "FORMAT_EPUB"
    public static var FORMAT_KINDLE = "FORMAT_KINDLE"
    public static var FORMAT_TEXT = "FORMAT_TEXT"
}

struct CodeResponse  {
    public static var success: Int = 200
    public static var failure: Int = 400
}

class DataSingleton
{
    public static var Story: FeedBookDataEntity?
    public static var Category: StoryEntity?
    public static var Author: AuthorEntity?
    public static var ViewCategory: Int?
    public static var SubCategory: String?
    
}
