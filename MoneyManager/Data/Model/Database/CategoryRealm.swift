//
// Created by hulkdx on 17/11/2018
//

import RealmSwift

class CategoryRealm: Object {
    @objc dynamic var id:       Int    = -1       
    @objc dynamic var name:     String = ""            
    @objc dynamic var hexColor: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
