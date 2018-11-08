//
// Created by hulkdx on 04/11/2018
//

import Alamofire
import SwiftyJSON

class NetworkService: NetworkServiceProtocol {
    
    // 
    // Urls
    // 
    static let BASE_URL             = "https://moneymanagerv2.herokuapp.com/api/"
    static let GET_TRANSACTIONS_URL: String = BASE_URL + "transactions/get"
    
    
    // Common headers function
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            // TODOxw
          "Authorization": "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNTQ2NzAzNzkxLCJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSJ9.YZZdCezKeQ7iLKCFfnXRh4ZaooAHMyI1uVZm1NOU74M"
        ]
        return headers
    }
    
    func getTransactions(completion: @escaping (DataResult<String>) -> () ) {
        print("getTransactions")
        Alamofire.request(NetworkService.GET_TRANSACTIONS_URL,
                          method: .get,
                          parameters: nil,
                          headers:    getHeaders())
            .responseJSON{ response in
                if response.result.isSuccess {
                    print("getTransactions, Success!")
                    var json : JSON = JSON(response.result.value!)
                    // TODO map the json to an object
                    completion(DataResult.success("Test"))
                } else {
                    print("getTransactions, Error: \(String(describing: response.result.error))")
                    completion(DataResult.failed(response.result.error))
                }
            }
    }
}


protocol NetworkServiceProtocol {
    func getTransactions(completion: @escaping (DataResult<String>) -> () )
}
