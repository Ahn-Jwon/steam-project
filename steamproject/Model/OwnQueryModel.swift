//
//  DBModel.swift
//  python
//
//  Created by TJ on 2023/09/18.
//

import Foundation

protocol UserQueryModelProtocol {
    func userItemDownloaded(items: [UserModel])
}
class steamQueryModel {
    var delegate: UserQueryModelProtocol!
    var userItems: [UserModel] = []
    var currentPage = 1 // 현재 페이지 번호를 관리
    
    let URLPath = "http://flask.okrie.kro.kr:5000/user/getusergames?steamid=76561198155183238"
    
    func steamDownloadItems(limit: Int) {
        let URL: URL = URL(string: "\(URLPath)&page=\(currentPage)&limit=\(limit)")!
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL) {
                DispatchQueue.main.async {
                    self.steamParseJSON(data, limit: limit)
                    print("Steam data 다운 성공")
                }
            } else {
                print("다운 실패")
            }
        }
    }
    
    func steamParseJSON(_ data: Data, limit: Int) {
        let decoder = JSONDecoder()
        var UserItems: [UserModel] = []
        
        do {
            let users = try decoder.decode(Usercount.self, from: data)
            var count = 0 // 현재까지 파싱한 개수를 세기 위한 변수
            
            for user in users.games {
                let query = UserModel(appid: user.appid, img_icon_url: user.img_icon_url, name: user.name)
                UserItems.append(query)
                //                print("appid \(query.appid)")
                count += 1
                if count >= limit {
                    break // 원하는 개수에 도달하면 파싱 종료
                }
            }
            print("파싱된 게임 수: \(UserItems.count)")
            
            print(users.games.count)
            
            // 배열 내용 확인
            for item in UserItems {
                print("UserItems - appid: \(item.appid), img_icon_url: \(item.img_icon_url), name: \(item.name)")
            }
        } catch let error {
            print("Fail: \(error.localizedDescription)")
        }
        
        self.userItems = UserItems // steamItems 배열 업데이트
        
        self.delegate.userItemDownloaded(items: UserItems) // delegate를 통해 호출
        
        let gameImageModel = OwnHeaderImageModel()
        gameImageModel.delegate = self.delegate as? OwnHeaderImageModelProtocol
        gameImageModel.downloadItemsFromSteamQueryModel(steamQueryModel: self)
    }
}


//
//class steamQueryModel {
//    var delegate: steamQueryModelProtocol!
//    var steamItems: [steamDBModel] = []
//
//    let steamURLPath = "http://flask.okrie.kro.kr:5000/user/getusergames?steamid=76561198155183238"
//
//    func steamDownloadItems() {
//        let steamURL: URL = URL(string: steamURLPath)!
//
//
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: steamURL) {
//                DispatchQueue.main.async {
//                    self.steamParseJSON(data)
//                    print(data)
//                }
//            } else {
//                print("Failed to download data")
//            }
//        }
//    }
//
//    func steamParseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
//        var steamItems: [steamDBModel] = []
//
//        do {
//            let steams = try decoder.decode(SteamResult.self, from: data)
//            for steam in steams.games {
//                let query = steamDBModel(appid: steam.appid, img_icon_url: steam.img_icon_url, name: steam.name)
//                steamItems.append(query)
//                print("appid \(query.appid)")
//            }
//
//            print(steams.games.count)
//
//            // steamItems 배열 내용 확인
//            for item in steamItems {
//                print("steamItem - appid: \(item.appid), img_icon_url: \(item.img_icon_url), name: \(item.name)")
//            }
//        } catch let error {
//            print("Fail: \(error.localizedDescription)")
//        }
//
//        DispatchQueue.main.async {
//            self.delegate.steamItemDownloaded(items: steamItems)
//
//            // Steam 게임 정보를 가져온 후, headerImageQueryModel에게 이미지 정보를 가져오도록 호출
//            let headerImageModel = headerImageQueryModel()
//            headerImageModel.delegate = self.delegate as? headerImageQueryModelProtocol
//            headerImageModel.downloadItemsFromSteamQueryModel(steamQueryModel: self)
//        }
//    }
//}
