//
//  Shopping.swift
//  Shopping List
//
//  Created by Mitya Kim on 1/19/22.
//

import UIKit

class Item: Codable {
    
    var title: String
    var body: String
    var isDone: Bool
    
    init (title: String, body: String, isDone: Bool = false) {
        self.title = title
        self.body = body
        self.isDone = isDone
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.title == rhs.title &&
               lhs.body == rhs.body &&
               lhs.isDone == rhs.isDone
    }
}
