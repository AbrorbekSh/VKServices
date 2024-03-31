//
//  ServiceModel.swift
//  ServicesInfo
//
//  Created by Аброрбек on 31.03.2024.
//

import Foundation

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let iconURL: String
    
    private enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
