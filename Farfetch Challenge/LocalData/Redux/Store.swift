//
//  Store.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 31/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import ReSwift

let mainStore = Store<AppState>(
    reducer: reducer,
    state: nil
)
