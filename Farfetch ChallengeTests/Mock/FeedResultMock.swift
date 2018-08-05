//
//  FeedResultMock.swift
//  Farfetch ChallengeTests
//
//  Created by Wallace Souza Silva on 05/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation

func feedResultData() -> Data {
    if let filePath = Bundle.main.path(forResource: "FeedResult", ofType: "json") {
        do {
            let url = URL(fileURLWithPath: filePath)
            return try Data(contentsOf:  url)
        } catch {
            print("ERROR: Erro ao abrir arquivo FeedResult.json")
        }
    }
    return Data()
}
