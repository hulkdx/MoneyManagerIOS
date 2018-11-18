//
// Created by hulkdx on 16/11/2018
//
// Fake injections class.
// Does swift/ios has some sort of injection libs?
//

class Injection {
    static func provideMainPresenter() -> MainPresenter<MainViewController> {
        let dataManager = provideDataManager()
        return MainPresenter(dataManager: dataManager)
    }

    static func provideDataManager() -> DataManagerProtocol {
        let networkService = provideNetworkService()
        let dbHelper = provideDatabaseHelperProtocol()
        return DataManager(networkService: networkService, databaseHelper: dbHelper)
    }

    static func provideNetworkService() -> NetworkServiceProtocol {
        return NetworkService()
    }
    
    static func provideDatabaseHelperProtocol() -> DatabaseHelperProtocol {
        let realmHelper = provideRealmHelper()
        return DatabaseHelper(realmHelper: realmHelper)
    }
    
    static func provideRealmHelper() -> RealmHelper {
        return RealmHelper()
    }
}
