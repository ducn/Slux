//
//  EventEmittor.swift
//  Pods
//
//  Created by Duc Ngo on 1/29/16.
//
//

import Foundation
public typealias EventType = String
public typealias EventCallback = Void->Void

public class EventListener{
    private var event:EventType
    private var callback:EventCallback
    internal init(event:EventType, callback:EventCallback){
        self.event = event
        self.callback = callback
    }
}

public class EventEmitter {
    public init(){}
    
    public func emit(eventType:EventType){
        if let ls = _listeners[eventType]{
            for l in ls {
                l.callback()
            }
        }
    }
    
    public func on(event:EventType, callback:EventCallback)->EventListener{
        return addListener(event, callback: callback)
    }
    
    public func addListener(event:EventType, callback:EventCallback)->EventListener{
        var listeners = getListenersForEvent(event)
        let newListener = EventListener(event: event, callback: callback)
        listeners.append(newListener)
        _listeners[event] = listeners
        return newListener
    }
    
    public func removeListener(event:EventType, listener:EventListener){
        _listeners[event] = _listeners[event]?.filter({ (l) -> Bool in
            return l !== listener
        })
    }
    
    private func getListenersForEvent(event:EventType)->[EventListener]{
        if let listeners = _listeners[event] { return listeners}
        else {return [EventListener]()}
    }
    
    private var _listeners = [EventType:[EventListener]]()
 
}