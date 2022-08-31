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

class User {

    private var listener: ((String) -> () )?
    
    var value: String {
        didSet {
            print("데이터 바뀜")
            listener?(value)
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
}
