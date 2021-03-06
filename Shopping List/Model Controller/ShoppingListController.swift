//
//  ShoppingListController.swift
//  Shopping List
//
//  Created by Juan M Mariscal on 2/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ShoppingListController {
    
    var items: [ShoppingItem] = []
    
    let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("shoppingItems.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createShoppingList(name: String) -> ShoppingItem {
        let item = ShoppingItem(itemName: name, itemAdded: false)
        items.append(item)
        saveToPersistentStore()
        


        return item
    }
    
    
    func saveToPersistentStore() {
        
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(items)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            items = try decoder.decode([ShoppingItem].self, from: data)
        } catch {
            print("error loading stars data: \(error)")
        }
    }
}
