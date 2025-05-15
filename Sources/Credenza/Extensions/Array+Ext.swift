//
//  Array+Ext.swift
//  Credenza
//
//  Created by Kuba on 5/15/25.
//

import Foundation

extension Array {

    mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2): (value1 > value2)
        }
    }

    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2): (value1 > value2)
        }
    }
}

extension Array where Element == AnyProduct {
    
    public var eventParameters: [String: Any] {
        var dict: [String: Any?] = [
            "products_count" : self.count,
            "products_ids" : self.compactMap({ $0.id }).sorted().joined(separator: ", "),
            "products_titles" : self.compactMap({ $0.title }).sorted().joined(separator: ", "),
        ]
        for product in self {
            for (key, value) in product.eventParameters {
                let uniqueKey = "\(key)_\(product.id)"
                dict[uniqueKey] = value
            }
        }
        return dict.compactMapValues({ $0 })
    }
}

extension Array where Element == PurchasedEntitlement {
    
    public var eventParameters: [String: Any] {
        let activeEntitlements = self.active
        var dict: [String: Any?] = [
            "entitlements_count_all" : count,
            "entitlements_count_active" : activeEntitlements.count,
            "entitlements_ids_all" : compactMap({ $0.id }).sorted().joined(separator: ", "),
            "entitlements_ids_active" : activeEntitlements.compactMap({ $0.id }).sorted().joined(separator: ", "),
            "entitlements_product_ids_all" : compactMap({ $0.productId }).sorted().joined(separator: ", "),
            "entitlements_product_ids_active" : activeEntitlements.compactMap({ $0.productId }).sorted().joined(separator: ", "),
            "has_active_entitlement" : hasActiveEntitlement
        ]
        for product in self {
            for (key, value) in product.eventParameters {
                let uniqueKey = "\(key)_\(product.productId)"
                dict[uniqueKey] = value
            }
        }
        return dict.compactMapValues({ $0 })
    }
}

public extension Array where Element == PurchasedEntitlement {
    
    /// All active entitlements
    var active: [PurchasedEntitlement] {
        self.filter({ $0.isActive })
    }
    
    /// TRUE if the user has at least one active entitlement
    var hasActiveEntitlement: Bool {
        !active.isEmpty
    }
}
