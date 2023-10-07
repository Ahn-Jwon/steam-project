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
    
    let steamURLPath = "http://flask.okrie.kro.kr:5000/user/login?userid=Okrie"
    
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
        
        do {
            let steams = try decoder.decode(SteamResult.self, from: data)
            var locations: [steamDBModel] = []
            for appid in steams.result.appid {
                let query = steamDBModel(appid: appid)
                locations.append(query)
            }
            
            print("파싱된 게임 수: \(locations.count)")
            
            for item in locations {
                print("steamItem - appid: \(item.appid)")
            }
            
            self.steamItems = locations
            self.delegate.steamItemDownloaded(items: locations)
            
            let headerImageModel = headerImageQueryModel()
            headerImageModel.delegate = self.delegate as? headerImageQueryModelProtocol
            headerImageModel.downloadItemsFromSteamQueryModel(steamQueryModel: self)
            
        } catch let error {
            print("오류 발생 @ : \(error.localizedDescription)")
        }
    }
    
}
