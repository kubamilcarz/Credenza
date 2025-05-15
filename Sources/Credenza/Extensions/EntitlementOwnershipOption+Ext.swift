//
//  EntitlementOwnershipOption+Ext.swift
//  Credenza
//
//  Created by Kuba on 5/15/25.
//

import StoreKit

extension EntitlementOwnershipOption {
    
    init(type: Transaction.OwnershipType) {
        switch type {
        case .purchased:
            self = .purchased
        case .familyShared:
            self = .familyShared
        default:
            self = .unknown
        }
    }
}
