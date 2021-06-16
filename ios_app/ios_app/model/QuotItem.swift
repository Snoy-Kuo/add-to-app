//
//  QuotItem.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/6/15.
//

struct QuotItem {
    let id: String
    let name: String
    var price: Double = 0.0
    
    var toJson : [String:Any] {
        //      let mirror = Mirror(reflecting: self)
        //      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        //        guard let label = label else { return nil }
        //        return (label, value)
        //      }).compactMap { $0 })
        //      return dict
        return [
            "id":id,
            "name":name,
            "price":price
        ]
    }
}
