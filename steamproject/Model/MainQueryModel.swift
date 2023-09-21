//
//  MainQueryModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

// Main page Query model
// JSON 형식을 연결한다.

import Foundation

// ViewModel을 만드는 파일이다.
// ViewModel을 Swift는 프로토콜로 넘겨준다.

// (1)
protocol QueryModelProtocol{
    func itemDownloaded(items: [DBModel]) // 테이블 뷰가 실행시켜서 화면에 노출 시킨다,
}

// (2) 최초 메인 이미지 (서버 체크 )
class QueryModel {
    var delegate: QueryModelProtocol!
    let urlPath = "http://flask.okrie.kro.kr:5000/game/bestgames"
    
    func downloadItems() {
        if let url = URL(string: urlPath) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    self.parseJSON(data)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let appidData = try decoder.decode(AppidJSON.self, from: data)
            var locations: [DBModel] = []

            for index in 0..<appidData.appid.count {
                let query = DBModel(
                    appid: appidData.appid[index],
                    snmae: appidData.name[index],
                    sprice: appidData.price[index])
                
                locations.append(query)
            }

            DispatchQueue.main.async {
                self.delegate.itemDownloaded(items: locations)
            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
}


