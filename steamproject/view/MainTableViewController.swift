//
//  MainTableViewController.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/18.

//  2023.09.18 MaintableController 생성 (mainPage)


import UIKit

class MainTableViewController: UITableViewController {
    
    
    // 최초 테이블 구성하는 화면 (Table View)
    @IBOutlet var tvListView: UITableView!
    
    //제이슨에서 불러온 아이템 변수
    var feedItem: [DBModel] = []
 
    
    // 최초 시작값
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 출발점 (1) 델리게이트 연결한다.
        let querModel = QueryModel()
        querModel.delegate = self
        querModel.downloadItems()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    // 테이블 컬럼의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 테이블 높이 지정 heightForRowA (강제 높이 지정)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // 테이블의 데이터 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count // 아이템의 갯수를 feedItem의 데이터 갯수로 지정한다.
    }

    // 테이블을 어디에 노출시킬것인지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        as! MainTableViewCell // 테이블셀의 디자인을 여기서 하기 때문에 이쪽으로 지정 (변수가 이쪽에 있기 떄문)
        
        let item = feedItem[indexPath.row]
        
//        var content = cell.defaultContentConfiguration()
       
//        cell.lbltitle.text = item.appid
        cell.lblprice.text = item.sname
        cell.lblappid.text = item.sprice
       

        
//        // 이미지 URL 문자열로 변경
        let imageURLString =
        "https://cdn.cloudflare.steamstatic.com/steam/apps/\(feedItem[indexPath.row].appid)/header.jpg"
        
        
        
//         Configure the cell...
//         이미지 문자열을 URL 객체로 변경 후 객체가 유효하면 다운로드하여 테이블뷰에 보여준다.
        if let imageURL = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                } else {
                    print("image 데이터 다운로드 실패") // 이미지 데이터 다운로드실패
                }
            }
        } else {
            print("image url 오류") // 이미지 url 오류
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // View Controller


// JSON Data 연결하기.
extension MainTableViewController: QueryModelProtocol{
    func itemDownloaded(items: [DBModel]) {
        feedItem = items
        self.tvListView.reloadData()
    }
}
