//
//  OwnModel.swift
//  steamproject
//
//  Created by TJ on 2023/09/26.
//

import Foundation

class UserModel{
    var appid: Int
    var img_icon_url: String
    var name: String
    
    init(appid: Int, img_icon_url: String, name: String) {
        self.appid = appid
        self.img_icon_url = img_icon_url
        self.name = name
    }
   
}

class IMGModel{
    var img_link : String
    var appid: Int
    var price: String
    var name: String
    
    init(img_link: String, appid: Int, price: String, name: String) {
        self.img_link = img_link
        self.appid = appid
        self.price = price
        self.name = name
    }
}
