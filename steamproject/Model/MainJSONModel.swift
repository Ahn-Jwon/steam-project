//
//  MainJSONModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//
// 2023.09.19(화) 샘플로 메인에 user 프로필 아이콘이미지 연결된 것 확인
// 2023.09.21(목) 메인에 사용될 새로운 JSON 서버생성 됨.
// JSON 형식의 구조와 똑같은 변수로 지어야 한다.

import Foundation
//
struct appid: Codable{
    let appid: [AppidJSON]
}

struct AppidJSON: Codable {
    let appid: [String]
    let name: [String]
    let price: [String]
}

struct name: Codable{
    let name: [NameJSON]
}

struct NameJSON: Codable {
    let name: [String]
}


