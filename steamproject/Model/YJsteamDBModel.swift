//
//  YJsteamDBModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

class steamDBModel {
    var appid: String

    init(appid: String) {
        self.appid = appid
    }
}


class headerImageDBModel{
    var img_link: String
    var price: String
    var name: String
    
    init(img_link: String, price: String, name: String) {
        self.img_link = img_link
        self.price = price
        self.name = name
    }
}

class steamUserInfoDBModel {
    var personaname: String?

    init(personaname: String?) {
        self.personaname = personaname
    }
}

