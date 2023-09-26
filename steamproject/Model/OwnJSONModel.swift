//
//  OwnJSONModel.swift
//  steamproject
//
//  Created by TJ on 2023/09/26.
//

import Foundation

struct Usercount: Codable {
    let games: [GameInfoJSON]
}

struct GameInfoJSON: Codable {
    var appid : Int
    var img_icon_url: String
    var name: String

    
}

struct Gamecount: Codable {
    let result: ImgJSON
}
struct ImgJSON: Codable{
//StudentJSON은 JSON파일 키 값(이름)과 같아야한다.
    var img_link: String
    var appid : Int

}
