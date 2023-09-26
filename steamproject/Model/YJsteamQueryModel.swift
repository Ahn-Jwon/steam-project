//
//  YJsteamQueryModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

protocol steamQueryModelProtocol {
    func steamItemDownloaded(items: [steamDBModel])
}

class steamQueryModels {
    var delegate: steamQueryModelProtocol!
    var steamItems: [steamDBModel] = []
    var currentPage = 1 // 현재 페이지 번호를 관리

    let steamURLPath = "http://flask.okrie.kro.kr:5000/user/getusergames?steamid=76561199337037872"

    func steamDownloadItems(limit: Int) {
        let steamURL: URL = URL(string: "\(steamURLPath)&page=\(currentPage)&limit=\(limit)")!
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: steamURL) {
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
        var steamItems: [steamDBModel] = []
        
        do {
            let steams = try decoder.decode(SteamResult.self, from: data)
            var count = 0 // 현재까지 파싱한 개수를 세기 위한 변수
            
            for steam in steams.games {
                let query = steamDBModel(appid: steam.appid, img_icon_url: steam.img_icon_url, name: steam.name)
                steamItems.append(query)
                count += 1
                
                if count >= limit {
                    break // 원하는 개수에 도달하면 파싱 종료
                }
            }
            
            print("파싱된 게임 수: \(steamItems.count)")
            
            // steamItems 배열 내용 확인
            for item in steamItems {
                print("steamItem - appid: \(item.appid), img_icon_url: \(item.img_icon_url), name: \(item.name)")
            }
        } catch let error {
            print("Fail: \(error.localizedDescription)")
        }
        
        self.steamItems = steamItems // steamItems 배열 업데이트
        self.delegate.steamItemDownloaded(items: steamItems) // delegate를 통해 호출
        
        let headerImageModel = headerImageQueryModel()
        headerImageModel.delegate = self.delegate as? headerImageQueryModelProtocol
        headerImageModel.downloadItemsFromSteamQueryModel(steamQueryModel: self)
    }
}

