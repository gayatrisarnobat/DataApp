//
//  DACommunicationManager.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import Foundation
import Alamofire

// MARK: URL Enum
enum DAURL: String {
    case main = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/"
}

// MARK: Communication Manager Class
class DACommunicationManager {
    private var delegate: DACommunicationManagerDelegate?
    
    init(delegate: DACommunicationManagerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchData(parameters: String) {
        // Create URL String
        let urlStr = DAURL.main.rawValue + parameters + ".json"
        
        // 1 Request
        let request = AF.request(urlStr)
        
        // 2
        request.responseJSON(completionHandler: { (data) in
            self.delegate?.didFetchData(data: data)
        })
    }
}

// MARK: Communication Manager Protocol
protocol DACommunicationManagerDelegate: AnyObject {
    func didFetchData(data: AFDataResponse<Any>?)
}
