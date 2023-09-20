//
//  MainDBModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

import Foundation

// Main page DB model
class DBModel{
    var appid: Int
    var simage: String
    var name: String
    
    init(appid: Int, simage: String, name: String) {
        self.appid = appid
        self.simage = simage
        self.name = name
    }
}
