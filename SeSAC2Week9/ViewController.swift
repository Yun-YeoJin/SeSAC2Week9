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
        
        
        let exmaple = User("고래밥")
        
        exmaple.bind { name in
            print("이름이 \(name)으로 바뀌었습니다.")
        }
        
        exmaple.value = "칙촉"
        exmaple.value = "아따맘마"
        
        let sample = User([1,2,3,4,5,])
        
        sample.bind { value in
            print(value)
        }
        
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2)
        
        number1 = 3
        number2 = 1
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { a in // 값이 달라지면 밑에 있던 것이 올라가서 표시가 되는거지???
             print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50
        
        viewModel.fetchPerson(query: "kim")
        viewModel.list.bind { person in
            print("viewController bind")
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

