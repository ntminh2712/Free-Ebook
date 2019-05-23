//
//  CategoryPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol CategoryView {
    
}

protocol CategoryPresent{
    func goToListStory()
    func setData(cell:CategoryTableViewCell,row:Int)
    func setListStory(row:Int)
    func presentListStoryCategory()
}

class CategoryPresentImplementation: CategoryPresent{
    var view: CategoryView?
    internal let router: CategoryViewRouter
    init(view: CategoryView, router: CategoryViewRouter) {
        self.view = view
        self.router = router
    }
    
    func setListStory(row:Int){
        listSubCategory = listCategory[row].children
    }
    
    
    func setData(cell: CategoryTableViewCell, row: Int) {
        cell.setData(item: listCategory[row])
    }
    
    func goToListStory() {
        self.router.presentListStory()
    }
    
    func presentListStoryCategory() {
        self.router.presentListStoryCategory()
    }
}
