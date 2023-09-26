//
//  YJsteamJSONModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

struct SteamResult: Codable{
    let games: [SteamJSON]
}

struct SteamJSON: Codable{
    var appid: Int
    var img_icon_url: String
    var name: String
}

struct headerImageResult: Codable {
    let result: headerImageJSON
}

struct headerImageJSON: Codable {
    let img_link: String
    let price: String
}


struct SteamUserInfoResult: Codable {
    let player: SteamUserInfoJSON
}

struct SteamUserInfoJSON: Codable {
    let personaname: String?
}






