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
    
    func getTransactions(completion: @escaping (DataResult<[Transaction]>) -> () ) {
        
        commonRequest(url:        NetworkService.GET_TRANSACTIONS_URL,
                      method:     HTTPMethod.get,
                      completion: completion)
        { json -> [Transaction] in
            var result = [Transaction]()
            // print(json)
            // Converting to object
            let amount_count = json["amount_count"] as! Int
            let response     = json["response"]     as! Array<NSDictionary>
            for response_transaction in (response) {
                // Only attachment and category are nullable!
                let id          = response_transaction["id"] as! Int
                let amount      = response_transaction["amount"] as! Float
                let attachment  = response_transaction["attachment"] as? String
                let date        = response_transaction["date"] as! String
                
                var category: Category? = nil
                if let category_response = response_transaction["category"] as? NSDictionary {
                    let id       = category_response["id"] as! Int
                    let name     = category_response["name"] as! String
                    let hexColor = category_response["hexColor"] as! String
                    
                    category = Category(id: id, name: name, hexColor: hexColor)
                }
                
                let transaction = Transaction(id: id,
                                              date: date,
                                              category: category,
                                              amount: amount,
                                              attachment: attachment)
                result.append(transaction)
            }
            
            return result
        }
    }

    func commonRequest<T> (url: String,
                           method: HTTPMethod,
                           paramethers: Parameters? = nil,
                           completion: @escaping (DataResult<[T]>) -> (),
                           onJsonReceived: @escaping (NSDictionary) -> ([T]))
    {
        Alamofire.request(url,
                          method: method,
                          parameters: paramethers,
                          headers:    getHeaders())
            .responseJSON{ response in
                
                var errorStr = ""
                
                if response.result.isSuccess {
                    print("getTransactions, Success!")
                    if let result = response.result.value {
                        let json = result as! NSDictionary
    
                        let result = onJsonReceived(json)
                        print(result)
                        completion(.success(result))
                        return
                    }
                    else
                    {
                        errorStr = "Cannot convert json."
                    }
                    
                } else {
                    errorStr = String(describing: response.result.error)
                }
                
                print("getTransactions \(errorStr)")
                completion(.failed(errorStr))
            }
    }
}


protocol NetworkServiceProtocol {
    func getTransactions(completion: @escaping (DataResult<[Transaction]>) -> () )
}
