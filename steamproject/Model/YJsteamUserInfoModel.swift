//
//  YJsteamUserInfoModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

protocol steamUserInfoModelProtocol {
    func steamUserInfoDownloaded(items: [steamUserInfoDBModel])
}

class steamUserInfoModel {
    var delegate: steamUserInfoModelProtocol!

    let urlPath = "http://flask.okrie.kro.kr:5000/user/getuser?steamid=76561198155183238"

    func steamUserInfoItems() {
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            self?.SteamUserInfoParseJSON(data)
        }
        task.resume()
    }

    func SteamUserInfoParseJSON(_ data: Data) {
        let decoder = JSONDecoder()

        do {
            let steamUser = try decoder.decode(SteamUserInfoResult.self, from: data)

            if let personaname = steamUser.player.personaname {
                let userInfo = steamUserInfoDBModel(personaname: personaname)
                DispatchQueue.main.async {
                    self.delegate.steamUserInfoDownloaded(items: [userInfo])
                }
            }
        } catch let error {
            print("Fail: \(error.localizedDescription)")
        }
    }
}
