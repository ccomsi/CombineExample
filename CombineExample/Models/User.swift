//
//  User.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2020/02/11.
//  Copyright © 2020 KIM JUNG HWAN. All rights reserved.
//

import Foundation

struct User2: Codable, Hashable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    struct Address: Codable, Hashable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
        
        private enum CodingKeys: String, CodingKey {
            case street
            case suite
            case city
            case zipcode
            case geo
        }
        
        struct Geo: Codable, Hashable {
            let lat: String
            let lng: String
            
            private enum CodingKeys: String, CodingKey {
                case lat
                case lng
            }
        }
    }

    struct Company: Codable, Hashable {
        let name: String
        let catchPhrase: String
        let bs: String
        
        private enum CodingKeys: String, CodingKey {
            case name
            case catchPhrase
            case bs
        }
    }
}

