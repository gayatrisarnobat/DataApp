//
//  DAListHelper.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

// MARK: List Helper Class
class DAListHelper {
    
    // MARK: Properties
    private weak var delegate: DAListHelperDelegate?
    
    // MARK: Initializer
    init(delegate: DAListHelperDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: Fetch List Data
    func fetchListData() {
        // check for connectivity here; if no connection, display cached data from Realm
        let isConnectivityAvailable = NetworkReachabilityManager()?.isReachable ?? false
        
        if isConnectivityAvailable {
            let communicationManager = DACommunicationManager(delegate: self)
            
            let parameter = "challenge"
            
            communicationManager.fetchData(parameters: parameter)
        }
        else {
            self.fetchOfflineData(error: nil)
        }
    }
    
    // Load Offline Data
    func fetchOfflineData(error: AFError?) {
        DispatchQueue.main.async {
            // fetch data from Realm and display
            let realm = try! Realm()
            let appDataList: Results<DAAppData> = { realm.objects(DAAppData.self) }()
            
            let data = appDataList.toArray(ofType: DAAppData.self)
            
            if data.count > 0 {
                self.delegate?.didFetchListData(data: data, error: nil)
            }
            else {
                self.delegate?.didFetchListData(data: nil, error: error ?? AFError.explicitlyCancelled)
            }
        }
    }
}

// MARK: List Helper Delegate
protocol DAListHelperDelegate: AnyObject {
    func didFetchListData(data: [DAAppData]?, error: AFError?)
}

// MARK: Communication Manager Delegate
extension DAListHelper: DACommunicationManagerDelegate {
    func didFetchData(data: AFDataResponse<Any>?) {
        if let af_data = data {
            if let responseData = af_data.data {
                do {
                    let appDataArray = try JSONDecoder().decode(Array<DAAppData>.self, from: responseData)
                    
                    // save this data to Realm for offline viewing
                    DispatchQueue.main.async {
                        let realm = try! Realm()
                        try! realm.write() {
                            for appData in appDataArray {
                                realm.add(appData)
                            }
                        }
                    }
                    
                    self.delegate?.didFetchListData(data: appDataArray, error: nil)
                } catch {
                    print("Could not parse data")
                    self.delegate?.didFetchListData(data: nil, error: AFError.parameterEncoderFailed(reason: AFError.ParameterEncoderFailureReason.encoderFailed(error: error)))
                }
            }
            else if let responseError = af_data.error {
                // fetch offline data
                self.fetchOfflineData(error: responseError)
            }
        }
    }
}
