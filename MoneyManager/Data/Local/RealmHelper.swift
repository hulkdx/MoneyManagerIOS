//
// Created by hulkdx on 17/11/2018
//

import RealmSwift

class RealmHelper {
    
    var config: Realm.Configuration
    
    init() {
        config = RealmHelper.getRealmConfig()
    }
    
    func getRealm() throws -> Realm {
        return try Realm(configuration: config)
    }
    
    static func getRealmConfig() -> Realm.Configuration {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        
        return config
    }
}
