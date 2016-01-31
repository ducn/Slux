//
//  DispatcherTestes.swift
//  Slux
//
//  Created by Duc Ngo on 1/31/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Slux

class DispatcherTestes: QuickSpec{
    override func spec() {
        describe("dispatch") { () -> () in
            let dispatcher = Dispatcher()
            var result = [String]()
            it("Should dispatch action"){
                dispatcher.register({ (action) -> Void in
                    switch(action.actionType){
                        case 100:
                            result.append(action.payload as! String)
                        break
                        default:
                        break
                        
                    }
                })
                dispatcher.register({ (action) -> Void in
                    switch(action.actionType){
                    case 100:
                        result.append(action.payload as! String)
                        break
                    default:
                        break
                    }
                })
                dispatcher.dispatch(Action(actionType: 100, payload: "todo"))
                expect(result.first).to(equal("todo"))
                expect(result.last).to(equal("todo"))
                expect(result.count).to(equal(2))
                result.removeAll()
                dispatcher.dispatch(Action(actionType: 0, payload: "todo"))
                expect(result.count).to(equal(0))
            }
        }
        
        describe("wait for") { () -> Void in
            let dispatcher = Dispatcher()
            it("Should wait for other actions"){
                var result = [String]()
                var d1 = "",d3 = ""
                
                d1 = dispatcher.register({ (action) -> Void in
                    result.append("d1 invoked")
                })
                
                dispatcher.register({ (action) -> Void in
                    dispatcher.waitFor([d1,d3])
                    result.append("d2 invoked")
                })
                
                d3 = dispatcher.register({ (action) -> Void in
                    result.append("d3 invoked")
                })
                dispatcher.dispatch(Action(actionType: 0, payload: "test"))
                expect(result.last).to(equal("d2 invoked"))
                expect(result.count).to(equal(3))
            }
        }
    }
    
}