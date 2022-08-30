//
//  Person.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/30.
//

import Foundation

struct Person: Codable {
    
    let page, totalPage, totalResults: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPage = "total_pages"
        case totalResults = "total_results"
        
    }
}

struct Result: Codable {
    let knownForDepartment, name: String
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        
    }
}
