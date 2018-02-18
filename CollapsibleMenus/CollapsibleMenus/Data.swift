//
//  Data.swift
//  CollapsibleMenus
//
//  Created by Mickey Goga on 2/15/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import Foundation

//MARK:- Step 1. Prepare the Data

//Let's say we have the following data that is grouped into different sections, each section is represented by a Section object:

struct Item {
    var name: String
    var detail: String
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

var sectionsData : [Section] = [
    Section(name: "Mac", items: [
        Item(name:"MacBook", detail:"MacBook detail"),
        Item(name:"MacBook Air", detail:"MacBook Air detail")]),
    Section(name: "iPad", items: [
        Item(name:"iPad Pro", detail:"iPad Pro detail"),
        Item(name:"iPad Air 2", detail:"iPad Air 2 detail")]),
    Section(name: "iPone", items: [
        Item(name:"iPhone 7", detail:"iPhone 7 detail"),
        Item(name:"iPhone 6", detail:"iPhone 6 detail")])
]

