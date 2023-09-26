//
//  YJFireBaseSteamTableViewController.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import UIKit
import Firebase
import FirebaseCore

class YJFireBaseSteamTableViewController: UITableViewController {
    
    @IBOutlet var firebaseSteamView: UITableView!
    
    

    var firebaseSteamListView : [FireBaseSteamDBModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        readVales()
    }
    
    func readVales(){
        let firebaseSteamQueryModel1 = firebaseSteamQueryModel()
        firebaseSteamQueryModel1.delegate = self
        firebaseSteamQueryModel1.firebaseDowmloadItems()
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return firebaseSteamListView.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        // content.text = firebaseSteamListView[indexPath.row].name
        
        // content.text = firebaseSteamListView[indexPath.row].price
        
        if let imageUrl = URL(string: firebaseSteamListView[indexPath.row].img_link){
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        content.image = image
                        cell.contentConfiguration = content
                    }
                }
            }.resume()
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

}
extension YJFireBaseSteamTableViewController: FireBaseSteamQueryModelProtocol{
    func steamItemDowmLoaded(items: [FireBaseSteamDBModel]) {
        firebaseSteamListView = items
        self.firebaseSteamView.reloadData()
    }
    
}
