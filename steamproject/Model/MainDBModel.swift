//
//  MainDBModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

// JSON
import Foundation

// Main page DB model
class DBModel{
    var appid: String
    var sname: String
//    var simage: String
    var sprice: String
    
    init(appid: String, snmae: String, sprice: String) {
        self.appid = appid
        self.sname = snmae
//        self.simage = simage
        self.sprice = sprice
    }
}
