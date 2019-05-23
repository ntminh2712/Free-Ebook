//
//  MenuEntity.swift
//  BaoVietOffice
//
//  Created by HOANPV on 10/9/18.
//  Copyright © 2018 Nava tech. All rights reserved.
//

import UIKit

class MenuEntity: NSObject {
    var name: String?
    var icon: String?
    var isSelected: Bool = false
    
    override init() {
        
    }
    init(_name: String, _icon: String, _isSelect: Bool = false)
    {
        self.name = _name
        self.icon = _icon
        self.isSelected = _isSelect
    }
   
    public static func initListInformation() -> [MenuEntity]
    {
        var list = [MenuEntity]()
        
        var item = MenuEntity(_name: "Home", _icon: "home", _isSelect: true)
        list.append(item)
        
        item = MenuEntity(_name: "My Library", _icon: "library", _isSelect: false)
        list.append(item)
        
        item = MenuEntity(_name: "Recommend for you", _icon: "recommend", _isSelect: false)
        list.append(item)
        
        item = MenuEntity(_name: "Rate app", _icon: "rate", _isSelect: false)
        list.append(item)
        item = MenuEntity(_name: "Share app", _icon: "share", _isSelect: false)
        list.append(item)
        
        item = MenuEntity(_name: "Give me feedback", _icon: "feedback", _isSelect: false)
        list.append(item)
        
        return list
    }
}
