//
//  YJsteamDBModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

class steamDBModel{
    var appid: Int
    var img_icon_url: String
    var name: String
    
    init(appid:Int, img_icon_url: String, name: String) {
        self.appid = appid
        self.img_icon_url = img_icon_url
        self.name = name
    }
}

class headerImageDBModel{
    var img_link: String
    var price: String
    
    init(img_link: String, price: String) {
        self.img_link = img_link
        self.price = price
    }
}

class steamUserInfoDBModel {
    var personaname: String?

    init(personaname: String?) {
        self.personaname = personaname
    }
}

