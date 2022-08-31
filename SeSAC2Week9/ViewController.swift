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
    
//    var list: Person = Person(page: 0, totalPage: 0, totalResults: 0, results: []) {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    private var viewModel = PersonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        LottoAPIManager.requestLotto(1025) { lotto, error in
//
//            guard let lotto = lotto else {
//                return
//            }
//                self.lottoLabel.text = lotto.drwNoDate
//
//        }
        
        viewModel.fetchPerson(query: "kim")
        
        viewModel.list.bind { person in

            self.tableView.reloadData()
            
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        return cell
    }
    
}

