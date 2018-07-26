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
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

enum TwitchClientState {
    case busy
    case ready
}

class TwitchClient {
    
    let baseUrl = "https://api.twitch.tv/helix/"
    var cursor: String = ""
    
    let headers: [String: String] = [
        "Client-ID": "xzqsdxt247xi72kder6l57r0aksbsh",
        "Accept": "application/vnd.twitchtv.v5+json",
        "Accept-Language": Bundle.main.preferredLocalizations.first ?? "en"
    ]
    
    var state: TwitchClientState = .ready
    
    var lastPageCursor: String? = nil
    
    func fetchNextPage(completion: @escaping (Result<GameFeedResult?, APIError>) -> Void) {
        guard state == .ready else {
            return
        }
        state = .busy
        
        let url = baseUrl + "games/top"
        var parameters: Parameters = [:]

        if let lastPageCursor = lastPageCursor {
            parameters["after"] = lastPageCursor
        }

        Alamofire.request(url, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                do {
                    let result: GameFeedResult = try unbox(dictionary: json)
                    self.lastPageCursor = result.pageCursor
                    completion(.success(result))
                } catch {
                    completion(.failure(.jsonParsingFailure))
                }
            }
            self.state = .ready
        }
    }
}
