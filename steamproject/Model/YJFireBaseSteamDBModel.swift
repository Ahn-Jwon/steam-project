//
//  YJFireBaseSteamDBModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

struct FireBaseSteamDBModel{
    var img_link: String
    var name: String
    var price: String
    
    init(img_link: String, name: String, price: String) {
        self.img_link = img_link
        self.name = name
        self.price = price
    }
}
