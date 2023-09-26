//
//  OwnHeaderImageModel.swift
//  steamproject
//
//  Created by TJ on 2023/09/26.
//

import Foundation

protocol OwnHeaderImageModelProtocol {
    func GameImageDownloaded(items: [IMGModel])
}

class OwnHeaderImageModel {
    var delegate: OwnHeaderImageModelProtocol!

    func downloadItemsFromSteamQueryModel(steamQueryModel: steamQueryModel) {
        print("steamItems 숫자: \(steamQueryModel.userItems.count)")

        // let appids = steamQueryModel.steamItems.compactMap { $0.appid }

        // let appids = steamQueryModel.steamItems.map { String($0.appid) }.joined(separator: ",")
        
        let appids = steamQueryModel.userItems.map { (UserDBModel) -> String in
            return String(UserDBModel.appid)
        }.joined(separator: ",")

        var locations: [IMGModel] = []

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
//                            print("성공 1 : \(appid)")
//                            print("성공 2 : \(data)")
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
            self.delegate.GameImageDownloaded(items: locations)
        }
    }

    func headerImageParseJSON(_ data: Data, locations: inout [IMGModel]) {
        let decoder = JSONDecoder()
        do {
            let games = try decoder.decode(Gamecount.self, from: data)
            let game = games.result
            let query = IMGModel(img_link: game.img_link, appid: game.appid, price: game.price, name: game.name)
            locations.append(query)
            print("성공 3 : \(game.img_link)")
        } catch let error {
            print("실패 사유 2 : \(error)")
        }
    }

}

    
    
  
