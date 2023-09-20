//
//  MainQueryModel.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

// Main page Query model
import Foundation

// ViewModel을 만드는 파일이다.
// ViewModel을 Swift는 프로토콜로 넘겨준다.

// (1)
protocol QueryModelProtocol{
    func itemDownloaded(items: [DBModel]) // 테이블 뷰가 실행시켜서 화면에 노출 시킨다,
}

// (2) 최초 메인 이미지 (서버 체크 )
class QueryModel{
    var delegate: QueryModelProtocol! // 옵셔널 체크를 해줘야 한다.
    let urlPath = "http://flask.okrie.kro.kr:5000/getusergames?steamid=76561198155183238" // 서버의 주소
    
    func dowloadItems(){
        let url: URL = URL(string: urlPath)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.parseJSON(data!)
            }
        }
    }
    
    // 2023.09.19 현재 데이터 안불러온다.
    // 2023.09.20 데이터 연결 완료.
    func parseJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: [DBModel] = []
        
        do{
            let mainss = try decoder.decode(game_count.self, from: data)
            for mains in mainss.games{
                let query = DBModel(appid: mains.appid, simage: mains.img_icon_url, name: mains.name)
                locations.append(query)
            }
            
            print(mainss.games.count)
        
            
        }catch let error{
            print("faill: \(error.localizedDescription)")
        }
        // 작업
        DispatchQueue.main.async{
            self.delegate.itemDownloaded(items: locations)
        }
        
    }
    
}


