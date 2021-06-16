//
//  MockRealtimeQuotRepo.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/6/15.
//

import Combine
import Dispatch

class MockRealtimeQuotRepo : RealtimeQuotRepo{
    
    private var fakeItem: QuotItem?
    private var delay: Int = 0
    
    init (fakeItem: QuotItem? = nil, delay: Int = 0){
        self.fakeItem = fakeItem
        self.delay = delay
    }
    
    private var isRealtime: Bool = false
    private var updateData = PassthroughSubject<QuotItem?,Never>()
    private var cancelable: Cancellable? = nil
    private var cancelable2: Cancellable? = nil
    
    private let dictProd = [
        "A" : "Android",
        "B" : "Basic",
        "C" : "C++",
        "D" : "Dart",
        "E" : "ECMAScript",
        "F" : "Flutter",
        "G" : "Go",
        "H" : "Haskell",
        "I" : "iOS",
        "J" : "Java",
        "K" : "Kotlin",
        "L" : "Lua",
        "M" : "MATLAB",
        "N" : "Nim",
        "O" : "ObjectiveC",
        "P" : "Python",
        "Q" : "Qt",
        "R" : "Ruby",
        "S" : "Swift",
        "T" : "TypeScript",
        "U" : "UNITY",
        "V" : "Visual FoxPro",
        "W" : "WebAssembly",
        "X" : "XML",
        "Y" : "YAML",
        "Z" : "Zsh",
    ]
    
    ///random duration from 100ms~500ms
    private func randomDelay() -> Int {
        return Int.random(in: 100...500)
    }
    
    ///random price from 100~999
    private func randomPrice() -> Double {
        return Double((Double.random(in: 100...999)*1000).rounded()/1000)
    }
    
    ///random product from _dictProd
    private func randomItem() -> QuotItem {
        let array: Array<(key:String, value:String)> = dictProd.map{($0, $1)}
        let index = Int.random(in:0...array.count-1)
        return QuotItem(id : array[index].key, name : array[index].value)
    }
    
    private func defaultFakeItem() -> QuotItem {
        var item = randomItem()
        item.price = randomPrice()
        return item
    }
    
    func observeRealtimeQuote() -> PassthroughSubject<QuotItem?,Never>{
        return updateData
    }
    
    func updateQuot() -> Future<QuotItem?, Never> {
        
        let delay:Int
        if (self.delay >= 1){
            delay = self.delay
        } else {
            delay = randomDelay()
        }
        usleep(useconds_t(delay*1000))
        
        return Future() { promise in
            DispatchQueue.global(qos: .background).async {
                promise(Result.success(self.fakeItem ?? self.defaultFakeItem()))
            }
        }
    }
    
    func toggleRealtimeQuote(enable: Bool) {
        isRealtime = enable
        if (isRealtime) {
            if (cancelable == nil) {
                cancelable = continueUpdate().sink {}
            }
        } else {
            cancelable?.cancel()
            cancelable = nil
            cancelable2?.cancel()
            cancelable2 = nil
        }
    }
    
    private func continueUpdate() -> Future<Void, Never>{
        return Future() { promise in
            DispatchQueue.global(qos: .background).async() {
                while (self.isRealtime) { // cancellable computation loop
                    self.cancelable2 = self.updateQuot()
                        .sink{ item in
                            self.updateData.send(item)
                        }
                }
                promise(Result.success(Void()))
            }
        }
    }
}
