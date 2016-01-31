//
//  EventEmitterTests.swift
//  Slux
//
//  Created by Duc Ngo on 1/31/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Slux

class EventEmitterTests: QuickSpec {
    let createEvent = "Create"
    let updateEvent = "Update"
    let deleteEvent = "Delete"
    
    override func spec() {
        describe("emitt") { () -> Void in
            let emitter = EventEmitter()
            var l = [EventListener]()
            var callback = 0

            beforeEach({ () -> Void in
                let l1 = emitter.on(self.createEvent, callback: {
                    callback = 1
                })
                let l2 = emitter.on(self.updateEvent, callback: {
                    callback = 2
                })
                let l3 = emitter.on(self.deleteEvent, callback: {
                    callback = 3
                })
                l.append(l1)
                l.append(l2)
                l.append(l3)
            })
        
            it("Should able to emit events"){
                emitter.emit(self.createEvent)
                expect(callback) == 1
                emitter.emit(self.updateEvent)
                expect(callback) == 2
                emitter.emit(self.deleteEvent)
                expect(callback) == 3
            }

            it("Should not emit to unregistered event"){
                callback = 0
                emitter.removeListener(self.createEvent, listener: l[0])
                emitter.emit(self.createEvent)
                expect(callback) == 0
            }
        }
    }
}