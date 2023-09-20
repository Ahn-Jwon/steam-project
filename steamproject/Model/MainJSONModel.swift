//
//  MainJSONModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

import Foundation

struct game_count: Codable{
    let games: [mainJSON]
}

struct mainJSON: Codable{
    var appid: Int
    var img_icon_url: String
    var name: String
}

