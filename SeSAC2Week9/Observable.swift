//
//  Observable.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/31.
//

import Foundation


//데이터를 담아주는 역할
class Observable<T> { //양방향 바인딩
    
    private var listener: ((T) -> () )?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> () ) {
        closure(value)
        listener = closure
    }
    
}

class User<T> {
    
    //    private var listener: (String, String) -> Void = { oldName, newName in
    //
    //        print("name changed: \(oldName) -> \(newName)")
    //
    //    }
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)// 매개변수로 oldvalue를 전달해줘야한다.
        }
    }
    
    init(_ value: T) { // 와일드카드로 외부매개변수 호출되지 않도록
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> Void) {
        completionHandler(value)
        listener = completionHandler
    }
    
}
