//
//  DownloadPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/25/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol DownloadView {
    
    
}


protocol DownloadPresent{
    func viewDidLoad()
    func presentDetailStory()
    func setData(cell:TopYesterdayCollectionViewCell,row:Int)
}
class DownloadPresentImplementation: LoadingAleart,DownloadPresent{
    var view: DownloadView?
    var downloadViewController: DownloadViewController
    init(view: DownloadView,downloadViewController: DownloadViewController) {
        self.view = view
        self.downloadViewController = downloadViewController
        
    }
    func setData(cell: TopYesterdayCollectionViewCell, row: Int) {
        cell.setDataRealm(data: listDownLoad[row])
    }
    func viewDidLoad(){
        
        
    }
    
    func presentDetailStory(){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        downloadViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
