//
//  Payload.swift
//  Pods
//
//  Created by Duc Ngo on 1/30/16.
//
//

import Foundation


public class Action{
    public var actionType:Int
    public var payload:AnyObject?
    public init(actionType:Int, payload:AnyObject?){
        self.actionType = actionType
        self.payload = payload
    }
}