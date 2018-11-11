//
// Created by hulkdx on 07/11/2018
//


enum DataResult<T> {
    case success(T, Any?)
    case failed(String?)
    
    init(t: T) {
        self = DataResult<T>.success(t, nil)
    }
}
