//
//  LibraryPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol LibraryView {
    func refresh()
    func activityStart()
    func activityStop()
}


protocol LibraryPresent{
    func viewDidLoad()
    func presentDetailStory()
    func setData(cell:TopYesterdayCollectionViewCell,row:Int)
}
class LibraryPresentImplementation: LoadingAleart,LibraryPresent{
    var view: LibraryView?
    var libraryViewController: LibraryViewController
    init(view: LibraryView,libraryViewController: LibraryViewController) {
        self.view = view
        self.libraryViewController = libraryViewController
        
    }
    func setData(cell: TopYesterdayCollectionViewCell, row: Int) {
        cell.setDataFavorites(data: listIdFavorites[row])
    }
    func viewDidLoad(){
    }
    
    func presentDetailStory(){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        libraryViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
