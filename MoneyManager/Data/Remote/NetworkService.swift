//
// Created by hulkdx on 04/11/2018
//

import Alamofire
import SwiftyJSON
import RxSwift

class NetworkService: NetworkServiceProtocol {
    
    // 
    // Urls
    // 
    static let BASE_URL             = "https://moneymanagerv2.herokuapp.com/api/"
    static let GET_TRANSACTIONS_URL = BASE_URL + "transactions/get"
    
    
    // Common headers function
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            // TODOxw
          "Authorization": "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNTQ2NzAzNzkxLCJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSJ9.YZZdCezKeQ7iLKCFfnXRh4ZaooAHMyI1uVZm1NOU74M"
        ]
        return headers
    }
    
    func getTransactions() -> Observable<[Transaction]> {
        
        return commonRequest(url:        NetworkService.GET_TRANSACTIONS_URL,
                             method:     HTTPMethod.get)
        { json -> ([Transaction], Int) in
            var result = [Transaction]()
            // Logger.log(json)
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
            
            return (result, amount_count)
        }
    }

    func commonRequest<T> (url: String,
                           method: HTTPMethod,
                           paramethers: Parameters? = nil,
                           onJsonReceived: @escaping (NSDictionary) -> (T, Any?)) -> Observable<T>
    {
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(url,
                                           method: method,
                                           parameters: paramethers,
                                           headers:    self.getHeaders())
                .responseJSON{ response in
                    
                    var errorStr = ""
                    
                    if response.result.isSuccess {
                        // Logger.log("getTransactions, Success!")
                        if let result = response.result.value {
                            let json = result as! NSDictionary
                            
                            let (res, extra) = onJsonReceived(json)
                            //Logger.log(result)
                            observer.onNext(res)
                            //completion(.success(result, extra))
                            return
                        }
                        else
                        {
                            errorStr = "Cannot convert json."
                        }
                        
                    } else {
                        errorStr = String(describing: response.result.error)
                    }
                    
                    Logger.log("getTransactions \(errorStr)")
                    
                    
                    observer.onError(NetworkError(reason: errorStr))
            }
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}


protocol NetworkServiceProtocol {
    func getTransactions() -> Observable<[Transaction]>
}

struct NetworkError: Error {
    let reason: String
}
