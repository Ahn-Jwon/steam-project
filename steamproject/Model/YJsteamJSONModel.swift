//
//  YJsteamJSONModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

struct SteamResult: Codable {
    let result: SteamJSON
}

struct SteamJSON: Codable {
    let appid: [String]
}

struct headerImageResult: Codable {
    let result: headerImageJSON
}

struct headerImageJSON: Codable {
    let img_link: String
    let price: String
    let name: String
}


struct SteamUserInfoResult: Codable {
    let player: SteamUserInfoJSON
}

struct SteamUserInfoJSON: Codable {
    let personaname: String?
}






