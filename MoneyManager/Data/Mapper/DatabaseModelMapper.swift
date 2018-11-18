//
// Created by hulkdx on 17/11/2018
//

import RealmSwift

class DatabaseModelMapper {
    
    static func convert(_ transactionRealm: TransactionRealm) -> Transaction {
        
        var category: Category? = nil
        if let categoryRealm = transactionRealm.category {
            category = convert(categoryRealm)
        }
        return Transaction(id: transactionRealm.id,
                           date: transactionRealm.date,
                           category: category,
                           amount: transactionRealm.amount,
                           attachment: transactionRealm.attachment)
    }
    
    static func convert(_ transaction: Transaction) -> TransactionRealm {
        let model = TransactionRealm()
        
        model.id         = transaction.id     
        model.date       = transaction.date
        model.amount     = transaction.amount         
        model.attachment = transaction.attachment
        
        if let category = transaction.category {
            model.category   = convert(category)
        }
        
        return model
    }
    
    static func convert(_ category: Category) -> CategoryRealm {
        let model = CategoryRealm()
        model.id       = category.id
        model.name     = category.name
        model.hexColor = category.hexColor
        return model
    }
    
    static func convert(_ categoryRealm: CategoryRealm) -> Category {
        return Category(id: categoryRealm.id, name: categoryRealm.name, hexColor: categoryRealm.hexColor)
    }
    
    static func convert(_ resultsTransactionRealm: Results<TransactionRealm>) -> [Transaction] {
        var model = [Transaction]()
        for transactionRealm in resultsTransactionRealm {
            model.append(convert(transactionRealm))
        }
        return model
    }
}
