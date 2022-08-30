//
//  URLSession+Extension.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult //반환값이 있어도 안쓸래.
    func customDataTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        return task
    }
    
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> () ) {
        
        session.customDataTask(endpoint){ data, response, error in //customDataTask에서 endpoint랑 completionHandler 보내준다.
            
        //URLSession.shared.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>).resume()
            
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
                    
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print(result)
                    completion(result, nil)
                    
                } catch {
                    
                    print(error)
                    completion(nil, .invalidData)
                    
                }
            }
        }
}
    
}

