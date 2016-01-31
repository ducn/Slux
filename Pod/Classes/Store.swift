//
//  BaseStore.swift
//  Pods
//
//  Created by Duc Ngo on 1/29/16.
//
//

import Foundation

public class Store{
    private var _emitter:EventEmitter
    private var _dispatchId:DispatchToken?
    private let _changeEvent = "ON_CHANGED"
    private var _changed:Bool = false
    
    var dispatcher:Dispatcher
    
    deinit{
        if let id = _dispatchId{
            dispatcher.unregister(id)
        }
    }
    
    public init(dispatcher:Dispatcher){
        self.dispatcher = dispatcher
        _emitter = EventEmitter()
        _dispatchId = dispatcher.register { [weak self](action) -> Void in
            self?.onDispacth(action)
        }
    }
    
    private func invokeOnDispatch(action:Action){
        _changed = false
        onDispacth(action)
        if _changed == true{
            _emitter.emit(_changeEvent)
        }
    }
    
    public func emitChange(){
        _changed = true
    }
    
    public func addListener(callback:EventCallback)->EventListener{
        return _emitter.on(_changeEvent, callback: callback)
    }
    
    public func onDispacth(action:Action){}
}