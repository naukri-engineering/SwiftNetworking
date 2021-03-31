//
//  ViewController.swift
//  SwiftNetworking
//
//  Created by Himanshu Gupta on 22/03/21.
//

import UIKit
enum cellType:String,CaseIterable{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case getWithQuery = "GET with query"
    case postWithQuery = "POST with query"
    case mulitpartUpload = "Multipart upload(Any Document,image or video(.mp4) file)"
}
class TableCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    var type: cellType?
    
    func configureCell(type:cellType){
        self.type = type
        self.label.text = type.rawValue
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension ViewController: UITableViewDelegate , UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celltype = cellType.allCases[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as? TableCell
        cell?.configureCell(type: celltype)
        if let cellExist = cell{
            return cellExist
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celltype = cellType.allCases[indexPath.row]
        let detailView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController

        detailView.type = celltype
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
}
