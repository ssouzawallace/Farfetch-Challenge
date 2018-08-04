//
//  TwitchClient.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

enum Result<T, E> where E: Error {
    case success(T)
    case failure(E)
}

enum APIError: Error {
    case jsonParsingFailure
    case notConnected
    
    var localizedDescription: String {
        switch self {
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .notConnected: return "Internet connection unavailable"
        }
    }
}

class TwitchClient {
    
    let baseUrl = "https://api.twitch.tv/helix/"
    let headers: [String: String] = [
        "Client-ID": "xzqsdxt247xi72kder6l57r0aksbsh",
        "Accept": "application/vnd.twitchtv.v5+json",
        "Accept-Language": Bundle.main.preferredLocalizations.first ?? "en"
    ]
    
    func fetchPage(after cursor: String?, completion: @escaping (Result<GameFeedResult, APIError>) -> Void) {
        let url = baseUrl + "games/top"
        var parameters: Parameters = [:]
        
        if let cursor = cursor {
            parameters["after"] = cursor
        }
        Alamofire.request(url, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                do {
                    let result: GameFeedResult = try unbox(dictionary: json)
                    completion(.success(result))
                } catch {
                    completion(.failure(.jsonParsingFailure))
                }
            } else {
                completion(.failure(.notConnected))
            }
        }
    }    
}
