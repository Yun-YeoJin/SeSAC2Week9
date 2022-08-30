//
//  LottoAPIManager.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/08/30.
//

import UIKit


//shared : 단순함, 커스텀X, 응답 클로저, delegate 사용 불가, 백그라운드 전송 X
//default configuration : 커스텀O(셀룰러 연결여부, 타임아웃간격), shared와 설정 유사, 응답 클로저 & 딜리게이트 가능
//init(configuration: .background) : 복잡

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    
    
    
    static func requestLotto(_ drwNo: Int, completion: @escaping (LottoModel?, APIError?) -> () ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
//        let a = URLRequest(url: url)
//        a.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        URLSession.shared.dataTask(with: url) { data, response, error in //실질적으론 error -> response -> data 순
            
            
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
                
                do {
                    
                    let result = try JSONDecoder().decode(LottoModel.self, from: data)
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
