//
//  DAAppData.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Enum for Identifying the Data Type
enum DAAppDataType: String {
    case text = "text"
    case image = "image"
    case other = "other"
}

// MARK: DAAppData Class
class DAAppData: Object, Decodable {
    @objc dynamic var id: String
    @objc dynamic var type: String
    @objc dynamic var date: String?
    @objc dynamic var data: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case date
        case data
    }
}
