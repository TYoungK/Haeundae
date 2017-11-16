

import UIKit

class TableViewController: UITableViewController,XMLParserDelegate {
    @IBOutlet var tebleview: UITableView!
    
    
    let listEndPoint = "http://openapi.haeundae.go.kr/openapi-data/service/rest/stayng/getStayingList"
    let detailEndPoint = "http://openapi.haeundae.go.kr/openapi-data/service/rest/stayng/getStayingDetailInfo"
    let serviceKey = "q02oYePjCHf2U4dWA9ixio0UzINsiRtOswSTONDU0rV4Ov1dtA6CYzyZ0CjuPMqljxLDThGZDOKqGv2%2BIIkZWQ%3D%3D"
    
    var item:[String:String] = [:]
    var items:[[String:String]] = []
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("data.plist")
        
        if fileManager.fileExists(atPath: url!.path){
            items = NSArray(contentsOf: url!) as! Array
        }else{
            getlist()
            let tempItems = items
            items = []
            for dic in tempItems{
                getdetail(idx: dic["seq"]!)
            }
            let temp = items as NSArray
            temp.write(to: url!, atomically: true)
        }
    }
    func getlist(){
        let str = listEndPoint + "?serviceKey=\(serviceKey)&numOfRows=1000"
        if let url = URL(string: str){
            if let parser = XMLParser(contentsOf: url){
                parser.delegate = self
                let success = parser.parse()
                if success{
                    print("성공")
                    print(items)
                }else{
                    print("실패")
                }
            }
        }
    }
    func getdetail(idx:String){
        let str = detailEndPoint + "?serviceKey=\(serviceKey)&seq=\(idx)"
        if let url = URL(string: str){
            if let parser = XMLParser(contentsOf: url){
                parser.delegate = self
                let success = parser.parse()
                if success{
                    print("성공")
                    print(items)
                }else{
                    print("실패")
                }
            }
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        key = elementName.trimmingCharacters(in: .whitespaces)
        if key == "item"{
            item = [:]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if item[key] == nil{
            item[key] = string.trimmingCharacters(in: .whitespaces)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            items.append(item)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        let dic = items[indexPath.row]
        /*
        if dic["accImage"] == nil{
        
        }else{
            let img = UIImage(named : dic["accImage"] as String!)
            cell.imageView?.image = img
        }
        */
        cell.textLabel?.text = dic["accName"]
        cell.detailTextLabel?.text = dic["address"]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detailItem = segue.destination as! DetailViewController
        // 테이블뷰에서 선택한 indexPath.row
            let selectedIndex = tableView.indexPathForSelectedRow
            detailItem.itemD = items[(selectedIndex?.row)!]
        }else if segue.identifier == "allItem"{
            let allItem = segue.destination as! allViewController
            // 테이블뷰에서 선택한 indexPath.row
            allItem.itemA = items
    }
    
}
}










