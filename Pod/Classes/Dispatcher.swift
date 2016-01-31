//
//  Dispatcher.swift
//  Pods
//
//  Created by Duc Ngo on 1/29/16.
//
//

import Foundation

public typealias DispatchToken = String
public typealias ActionCallback = Action -> Void

public class Dispatcher{

    private var _listeners = [DispatchToken:DispatchListener]()
    private var _listenerId:Int = 0
    private var _isDispatching:Bool = false
    private var _pendingAction:Action?
    
    public init(){}
    
    
    //MARK:- Core
    public func register(callback:ActionCallback)->DispatchToken{
        let token = "DISPATCH_LISTENER_\(++_listenerId)"
        _listeners[token] = DispatchListener(callback: callback)
        return token
    }
    
    public func unregister(id:DispatchToken){
        _listeners.removeValueForKey(id)
    }
    
    public func dispatch(action:Action){
        guard _isDispatching == false else {return}
        startDispatching(action)
        for token in _listeners.keys{
           invokeCallback(_listeners[token])
        }
        stopDispatching()
    }
    
    public func waitFor(tokens:[DispatchToken]){
        guard _isDispatching == true else {return}
        for token in tokens{
            if _listeners[token]?.status == .Pending ||
                _listeners[token]?.status == .Handled{
                    continue
            }
            invokeCallback(_listeners[token])
        }
    }
    
    private func startDispatching(action:Action){
        _isDispatching = true
        _pendingAction = action
        for key in _listeners.keys{
            _listeners[key]?.status = .Ready
        }
    }
    
    private func stopDispatching(){
        _pendingAction = nil
        _isDispatching = false
    }
    
    private func invokeCallback(listener:DispatchListener?){
        guard let action = _pendingAction else {return}
        guard let l = listener else {return}
        guard l.status == .Ready else {return}
        l.status = .Pending
        l.callback(action)
        l.status = .Handled
    }
    
    enum DispatchStatus{
        case Ready, Pending, Handled
    }
    
    class DispatchListener {
        var callback:ActionCallback
        var status:DispatchStatus
        init(callback:ActionCallback){
            self.callback = callback
            self.status = .Ready
        }
    }
}
