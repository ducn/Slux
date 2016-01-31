//
//  TodoStore.swift
//  Slux
//
//  Created by Duc Ngo on 1/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Slux

class TodoStore:Store {
    static let sharedInstance = Store(dispatcher: AppDispatcher.sharedInstance)
    override func onDispacth(action: Action) {
        let actionType = ActionType(rawValue: action.actionType)
        switch actionType!{
            case .Create:
                // Save to store
                // emit change
                emitChange()
            break
            default:
            break
        }
    }
}