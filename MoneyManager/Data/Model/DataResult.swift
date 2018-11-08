//
// Created by hulkdx on 07/11/2018
//


enum DataResult<T> {
    case success(T)
    case failed(Error?)
}
