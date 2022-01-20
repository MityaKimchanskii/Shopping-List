//
//  ItemController.swift
//  Shopping List
//
//  Created by Mitya Kim on 1/19/22.
//

import Foundation

class ItemController {
    
    // Singleton
    static let shared = ItemController()
    
    // Source of Truth
    var items: [Item] = []
    
    // MARK: - CRUD
    // Create Item
    func addItem(title: String, body: String, quality: Int) {
        let newItem = Item(title: title, body: body)
        items.append(newItem)
        saveToPS()
    }
    
    // Update Item
    func updateItem(item: Item, title: String, body: String) {
        item.title = title
        item.body = body
        saveToPS()
    }
    
    // Delete Item
    func deleteItem(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPS()
    }
    
    // Mark: - Other Methods
    func toggleIsDone(item: Item) {
        item.isDone.toggle()
        saveToPS()
    }
    
    // Persistence Store
    // URL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("ShoppingList.json")
        return url
    }
    
    // Save to Persistence Store
    func saveToPS() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(items)
            try data.write(to: fileURL())
        } catch {
            print("Encoder error")
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // Load from Persistence Store
    func loadFromPS() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            items = try jsonDecoder.decode([Item].self, from: data)
        } catch {
            print("Decoder error")
            print(error)
            print(error.localizedDescription)
        }
    }
}
