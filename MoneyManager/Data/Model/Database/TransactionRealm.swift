//
// Created by hulkdx on 17/11/2018
//
//
//

import RealmSwift

class TransactionRealm: Object {
    @objc dynamic var id:         Int            = -1            
    @objc dynamic var date:       String         = ""               
    @objc dynamic var category:   CategoryRealm? = nil                       
    @objc dynamic var amount:     Float          = -1             
    @objc dynamic var attachment: String?        = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
