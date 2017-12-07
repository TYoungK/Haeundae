

import UIKit

class TableViewController: UIViewController,XMLParserDelegate,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tebleview: UITableView!
    
    
    let listEndPoint = "http://openapi.haeundae.go.kr/openapi-data/service/rest/stayng/getStayingList"
    let detailEndPoint = "http://openapi.haeundae.go.kr/openapi-data/service/rest/stayng/getStayingDetailInfo"
    let serviceKey = "q02oYePjCHf2U4dWA9ixio0UzINsiRtOswSTONDU0rV4Ov1dtA6CYzyZ0CjuPMqljxLDThGZDOKqGv2%2BIIkZWQ%3D%3D"
    @IBOutlet var myTV: UITableView!
    @IBOutlet var AcIndicator: UIActivityIndicatorView!
    var item:[String:String] = [:]
    var items:[[String:String]] = []
    var key = ""
    
    var totalCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        AcIndicator.startAnimating()
        
        // Do any additional setup after loading the view.
        myTV.dataSource = self
        myTV.delegate = self
        
        self.title = "해운대구 숙박업소"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("data.plist")
        
       
        getList(numOfRows: 0)
        
        if fileManager.fileExists(atPath: (url?.path)!) {
            items = NSArray(contentsOf: url!) as! Array
            if (items.count != totalCount) {
                getList(numOfRows: totalCount)
                saveDetail(url: url!)
            }
        } else {
            getList(numOfRows: totalCount)
            saveDetail(url: url!)
        }
        myTV.reloadData()
    }
    
    func getList(numOfRows:Int) {
        let str = listEndPoint + "?serviceKey=\(serviceKey)&numOfRows=\(numOfRows)"
        //print(str)
        
        if let url = URL(string: str) {
            if let parser = XMLParser(contentsOf: url) {
                
                parser.delegate = self
                let success = parser.parse()
                if success {
                    print("parse success in getList")
                    print("totalCount = \(totalCount)")
                    
                } else {
                    print("parse failed in hetList")
                }
            }
        }
    }
    
    func getDetail(idx: String) {
        let str = detailEndPoint + "?serviceKey=\(serviceKey)&seq=\(idx)"
        
        if let url = URL(string: str) {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                let success = parser.parse()
                if success {
                    print("parse success in getDetail")
                    print(items)
                    
                } else {
                    print("parse fail in getDeatil")
                }
            }
        }
    }
    
    //*******새로 추가된 함수 - 목록데이터를 가지고 상세데이터를 가져와서 저장하는 함수
    // Detail Data 가져오는 부분을 saveDetail 메소드로 extract
    func saveDetail(url:URL) {
        
        // "loc" key로 items를 sort
        let sortedItems = items.sorted{($1["seq"])! > ($0["seq"])!}
        let tempItems = sortedItems  // tableView에서 재활용
        //print("items = \(items)")
        
        items = []
        
        //-----------------thread controll----------------------
        //-------DispatchQueue선언(멀티 thread)-------------------
        //qos 속성에 따라 우선순위 변경
        let equeue = DispatchQueue(label:"com.yangsoo.queue", qos:DispatchQoS.userInitiated)
        //-------xml parxer(background thread사용)---------------
        equeue.async {
            for dic in tempItems {
                // 상세 목록 파싱
                self.getDetail(idx: dic["seq"]!)
                //-------tableview(main thread사용(ui는 main thread 사용 필수))---
                DispatchQueue.main.async {
                    self.myTV.reloadData()
                    let temp = self.items as NSArray  // NSArry는 화일로 저장하기 위함
                    temp.write(to: url, atomically: true)
                }
            }
            
        }
        //-----------------thread controll------------------------
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        key = elementName.trimmingCharacters(in: .whitespaces)
        if key == "item"{
            item = [:]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if item[key] == nil {
            item[key] = string.trimmingCharacters(in: .whitespaces)
            //print("item(\(key)) = \(item[key])")
            
            //*******key가 totalCount 이면 totalCount 변수에 저장
            if key == "totalCount" {
                totalCount = Int(string.trimmingCharacters(in: .whitespaces))!
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(item)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 11 {
            self.AcIndicator.stopAnimating()
            self.AcIndicator.hidesWhenStopped = true
        }
        

        let cell = myTV.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TableViewCell
        
        let dic = items[indexPath.row]
//
//        let imgurl = dic["accImage"]
//        cell.imageView?.downloadedFrom(link: imgurl!)
        
        cell.self.img.setImageFromURl(stringImageUrl: dic["accImage"]!)
        cell.name.text = dic["accName"]
        cell.adr.text = dic["address"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detailItem = segue.destination as! DetailViewController
        // 테이블뷰에서 선택한 indexPath.row
            let selectedIndex = myTV.indexPathForSelectedRow
            detailItem.itemD = items[(selectedIndex?.row)!]
        }else if segue.identifier == "allItem"{
            let allItem = segue.destination as! allViewController
            // 테이블뷰에서 선택한 indexPath.row
            allItem.itemA = items
    }
    
}
}










