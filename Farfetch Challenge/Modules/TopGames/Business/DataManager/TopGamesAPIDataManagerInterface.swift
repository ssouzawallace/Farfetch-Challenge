//
//  TopGamesAPIDataManagerInterface.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

protocol TopGamesAPIDataManagerInterface {
    func fetchPage(after cursor: String?, completion: @escaping (Result<GameFeedResult, APIError>) -> Void)
}
