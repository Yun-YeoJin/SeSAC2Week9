//
//  PersonAPIManager.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(_ query: String, completion: @escaping (Person?, APIError?) -> () ) {
        
//        let url = URL(string:  "https://api.themoviedb.org/3/search/person?api_key=APIKey&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = APIKey.TMDB
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
            
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in //실질적으론 error -> response -> data 순
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                //네 개의 경우가 다 문제가 없으면 do_catch문 실행
                do {
                    
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    print(result)
                    completion(result, nil)
                    
                } catch {
                    
                    print(error)
                    completion(nil, .invalidData)
                    
                }
            }
            
        }.resume()
        
    }
}
