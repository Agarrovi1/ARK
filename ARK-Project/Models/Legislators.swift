//
//  Legislators.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//
import Foundation

// MARK: - CongressWoman
struct CongressWoman: Codable {
    let results: [ResultWrapper]?
    
    static func decodeLegislators(from data: Data) -> [Member]? {
      do {
        let newMembers = try JSONDecoder().decode(CongressWoman.self, from: data)
        if let result = newMembers.results {
            return result[0].members
        }
        return []
      } catch let decodeError {
        print(decodeError)
        return nil
      }
    }
}

// MARK: - Result
struct ResultWrapper: Codable {
        let members: [Member]?

    
}

// MARK: - Member
struct Member: Codable {
    let firstName: String?
    let lastName: String?
    let phone: String?
    let state: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case phone, state
    }
}

