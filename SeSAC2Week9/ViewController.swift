//
//  ViewController.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/30.
//

import UIKit



class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var lottoLabel: UILabel!
    
    var list: Person = Person(page: 0, totalPage: 0, totalResults: 0, results: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LottoAPIManager.requestLotto(1025) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
                self.lottoLabel.text = lotto.drwNoDate
            
        }
        
        PersonAPIManager.requestPerson("Kim") { person, error in
            guard let person = person else {
                return
            }
           dump(person)
            self.list = person
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.results.count //옵셔널이라서 nil이 올 수 있다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = list.results[indexPath.row].name
        cell.detailTextLabel?.text = list.results[indexPath.row].knownForDepartment
        return cell
    }
    
}

