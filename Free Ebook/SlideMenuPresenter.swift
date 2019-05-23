//
//  SlideMenuPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/9/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation

protocol SlideMenuPresent: class{
    func viewDidload()
    var numberSection:Int{get}
    func numberRowInSession(session: Int) -> Int
    func setData(cell: MenuTableViewCell, row: Int)
    func cellSelect( row: Int)
}

class SlideMenuPresentImplementation: SlideMenuPresent
{
    func numberRowInSession(session: Int) -> Int {
        return listMenu.count
    }
    let view: SlideMenuView?
    fileprivate var listMenu: [MenuEntity] = MenuEntity.initListInformation()
    var numberSection: Int{
        return listMenu.count
    }
    
    init(view: SlideMenuView) {
        self.view = view
    }
    
    func viewDidload() {
        
    }
    
    func cellSelect(row: Int) {
        reloadMenu(row: row)
    }
    func reloadMenu(row:Int){
        for item in listMenu {
            item.isSelected = false
        }
        listMenu[row].isSelected = true
        self.view?.refreshData()
    }
    func setData(cell: MenuTableViewCell, row: Int)
    {
        cell.setData(data: listMenu[row])
    }
    
}
