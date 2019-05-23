
//
//  DetailPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import FolioReaderKit
import Alamofire
protocol DetailView {
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
    func hiddenSameAuthor()
}

protocol DetailPresent{
    func setData(cell:DetailTableViewCell)
    func viewDidLoad()
    func search(keyword:String)
    func presentDetail()
    func downloadCountStory(id:Int)
    func presentListStory()
    func download(url:String, name:String)
    func readBook()
    func saveDownloadLocal()
    func getSameCategory()
    func getSameAuthor()
}
var listSameAuthor:[FeedBookDataEntity] = []
var listSameCategory:[FeedBookDataEntity] = []
class DetailPresentImplementation: LoadingAleart,DetailPresent{
    var offset:Int = 0
    var detailViewController: DetailViewController!
    var view: DetailView?
    internal let router: DetailViewRouter
    var feedbookGateway:FeedBookGateway
    var allStoryCategoryGateway: AllListStoryCategoryGateway!
    init(view: DetailView, router: DetailViewRouter, allStoryCategoryGateway: AllListStoryCategoryGateway,detailViewController: DetailViewController,feedbookGateway:FeedBookGateway) {
        self.view = view
        self.router = router
        self.allStoryCategoryGateway = allStoryCategoryGateway
        self.detailViewController = detailViewController
        self.feedbookGateway = feedbookGateway
    }
    
    func setData(cell: DetailTableViewCell) {
        cell.setData(item: DataSingleton.Story!)
    }
    func viewDidLoad() {
        getDetail()
        getSameAuthor()
        getSameCategory()
    }
    func presentListStory(){
        self.router.presentListStory()
    }
    func checkFavorites(list: Array<FeedBookDataEntity>) {
        for i in 0..<list.count {
            for x in 0..<listIdFavorites.count {
                if listIdFavorites[x].id == list[i].id {
                    list[i].isFavorites = true
                }
            }
            for x in 0..<listDownLoad.count {
                if listDownLoad[x].id == list[i].id{
                    list[i].isDownload = true
                }
            }
        }
    }
    func presentDetail() {
        self.router.presentDetail()
    }
    
    
    func readBook() {
        let config = FolioReaderConfig()
        config.scrollDirection = .horizontal
        let folioReader = FolioReader()
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            let filePath = dir.appendingFormat("/pg\((DataSingleton.Story?.no)!)-images.epub")
            folioReader.presentReader(parentViewController: detailViewController, withEpubPath: filePath, andConfig: config)
        } else {
            print("Could not find local directory to store file")
            return
        }
    }
    
    
    func download(url:String, name:String) {
        let url = URL(string: url)
        let destination = DownloadRequest.suggestedDownloadDestination()
        Alamofire.download(url!, to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
            print("Progress: \(progress.fractionCompleted)")
            let progress:[String: Float] = ["progress": Float(progress.fractionCompleted)]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName.updateProgress.rawValue), object: nil, userInfo: progress)
            } .validate().responseData { ( response ) in
                let id: [String: Int] = ["idStory": (DataSingleton.Story?.id)!]
                NotificationCenter.default.post(name: NSNotification.Name(notificationName.downloadSuccess.rawValue), object: nil, userInfo: id)
        }
    }
    func saveDownloadLocal() {
        var urlDownload:String?
        for i in 0..<DataSingleton.Story!.links!.count {
            if DataSingleton.Story?.links![i].format == Format.FORMAT_EPUB_IMAGE {
                urlDownload = DataSingleton.Story!.links![i].url
            }
        }
        if urlDownload != nil {
            download(url: urlDownload!, name: String((DataSingleton.Story?.id)!))
        }else {
            return
            AlertHepper(title: TitleAlert.error, message: TitleAlert.unavilable, ViewController: detailViewController)
            
        }
        
        let story: StoryRealmEntity = StoryRealmEntity()
        story.no = (DataSingleton.Story?.no)!
        story.id = (DataSingleton.Story?.id)!
        story.links = urlDownload!
        story.picture = DataSingleton.Story?.picture
        story.title = DataSingleton.Story?.title
        story.isFavorites = false
        story.categoryId = DataSingleton.Story!.category!.id!
        if DataSingleton.Story?.authors.count != 0 {
            story.authors = DataSingleton.Story?.authors[0].name
            story.authorId = (DataSingleton.Story?.authors[0].id)!
        }
        StoryRealmEntity.saveStoryDownload(story)
    }
    
    func getDetail() {
        self.view!.activityStart()
        allStoryCategoryGateway.getDetailStory(id: (DataSingleton.Story?.id)!) { (result) in
            switch result {
            case let .success(data):
                DataSingleton.Story = data.dataFeedBook
                self.view!.activityStop()
                self.view?.refresh()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func getSameAuthor() {
        self.view!.activityStart()
        if DataSingleton.Story?.authors.count == 0 {
            self.view!.hiddenSameAuthor()
        } else {
            if let idAuthor = DataSingleton.Story?.authors[0].id {
                allStoryCategoryGateway.getSameAuthor(id: idAuthor, limit: 10) { (result) in
                    switch result {
                    case let .success(data):
                        if data._result.count != 0 {
                            listSameAuthor = data._result
                        }
                        self.checkFavorites(list: listSameAuthor)
                        self.view!.activityStop()
                        self.view?.refresh()
                        break
                    case let .failure(error):
                        self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailViewController)
                        self.view!.activityStop()
                        break
                    }
                }
            }else {
                return
            }
        }
        
    }
    func getSameCategory() {
        self.view!.activityStart()
        allStoryCategoryGateway.getSameCategory(id: ((DataSingleton.Story?.category?.id)!), limit: 10, offset: offset) { (result) in
            switch result {
            case let .success(data):
                listSameCategory = data._result
                self.checkFavorites(list: listSameCategory)
                self.view!.activityStop()
                self.view?.refresh()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func search(keyword:String){
        if keyword.count >= 2{
            feedbookGateway.search(keyword: keyword) { (result) in
                switch result {
                case let .success(data):
                    if data.code == 0 {
                        if data.result?.data.count != 0 {
                            listSearch = (data.result?.data)!
                        }
                    }
                    self.view!.activityStop()
                    self.view!.checkSearchRender()
                    self.view!.refresh()
                    break
                case let .failure(error):
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailViewController)
                    self.view!.activityStop()
                    break
                }
            }
        }else {
            listSearch.removeAll()
            self.view!.checkSearchRender()
            self.view!.refresh()
        }
    }
    func downloadCountStory(id:Int){
        allStoryCategoryGateway.downloadStory(id: id)
    }
    
}
