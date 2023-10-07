//
//  YJheaderImageQueryModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

protocol headerImageQueryModelProtocol {
    func headerImageDownloaded(items: [headerImageDBModel])
}

class headerImageQueryModel {
    var delegate: headerImageQueryModelProtocol!

    func downloadItemsFromSteamQueryModel(steamQueryModel: steamQueryModels) {
        print("steamItems 숫자: \(steamQueryModel.steamItems.count)")

        // let appids = steamQueryModel.steamItems.compactMap { $0.appid }

        // let appids = steamQueryModel.steamItems.map { String($0.appid) }.joined(separator: ",")
        
        let appids = steamQueryModel.steamItems.map { (steamDBModel) -> String in
            return String(steamDBModel.appid)
        }.joined(separator: ",")

        var locations: [headerImageDBModel] = []

        let dispatchGroup = DispatchGroup()

        let appidArray = appids.components(separatedBy: ",")


        for appid in appidArray {
            let urlString = "http://flask.okrie.kro.kr:5000/game/searchgamesid?searchid=\(appid)"
            if let url = URL(string: urlString) {
                dispatchGroup.enter()
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            self.headerImageParseJSON(data, locations: &locations)
                            print("성공 1 : \(appid)")
                            print("성공 2 : \(data)")
                            dispatchGroup.leave()
                        }
                    } catch let error {
                        print("실패 : \(appid)")
                        print("실패 사유 1 : \(error)")
                        dispatchGroup.leave()
                    }
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("모든 요청 완료")
            self.delegate.headerImageDownloaded(items: locations)
        }
    }

    func headerImageParseJSON(_ data: Data, locations: inout [headerImageDBModel]) {
        let decoder = JSONDecoder()
        do {
            let headerImages = try decoder.decode(headerImageResult.self, from: data)
            let headerImage = headerImages.result
            let query = headerImageDBModel(img_link: headerImage.img_link, price: headerImage.price, name: headerImage.name)
            locations.append(query)
            print("성공 3 : \(headerImage.img_link) , \(headerImage.price) ")
        } catch let error {
            print("실패 사유 2 : \(error)")
        }
    }

}

    
    
  
