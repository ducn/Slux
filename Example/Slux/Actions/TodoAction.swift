//
//  TodoAction.swift
//  Slux
//
//  Created by Duc Ngo on 1/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Slux

class TodoAction{
    class func create(text:String){
        AppDispatcher.sharedInstance.dispatch(Action(actionType:ActionType.Create.rawValue, payload: nil))
    }
}