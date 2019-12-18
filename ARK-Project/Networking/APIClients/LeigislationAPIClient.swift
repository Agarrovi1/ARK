//
//  LeigislationAPIClient.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import Foundation

struct LegislatorsAPIClient {
    private init() {}
    static let shared = LegislatorsAPIClient()
    
    func getMembersInfo(state: String , completionHandler: @escaping (Result<[Member], AppError>) -> ()) {
        let urlStr = "https://api.propublica.org/congress/v1/116/senate/members.json"

        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
                
            case .success(let data):
                
                do {
                    let congressWomen = try CongressWoman.decodeLegislators(from: data)
                    completionHandler(.success(congressWomen!))
                }
                catch {
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
}
