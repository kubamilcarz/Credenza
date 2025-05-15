//
//  PurchasedEntitlement.swift
//  Credenza
//
//  Created by Kuba on 5/15/25.
//

import Foundation
import SwiftUI

public struct PurchasedEntitlement: Codable, Sendable {
    
    // For StoreKit, this is the transaction ID
    // For RevenueCat, this is a unique ID they provide (they abstract away the transaction)
    public let id: String
    public let productId: String
    public let expirationDate: Date?
    public let isActive: Bool
    public let originalPurchaseDate: Date?
    public let latestPurchaseDate: Date?
    public let ownershipType: EntitlementOwnershipOption
    public let isSandbox: Bool
    public let isVerified: Bool
    
    public init(
        id: String,
        productId: String,
        expirationDate: Date?,
        isActive: Bool,
        originalPurchaseDate: Date?,
        latestPurchaseDate: Date?,
        ownershipType: EntitlementOwnershipOption,
        isSandbox: Bool,
        isVerified: Bool
    ) {
        self.id = id
        self.productId = productId
        self.expirationDate = expirationDate
        self.isActive = isActive
        self.originalPurchaseDate = originalPurchaseDate
        self.latestPurchaseDate = latestPurchaseDate
        self.ownershipType = ownershipType
        self.isSandbox = isSandbox
        self.isVerified = isVerified
    }

    public var expirationDateCalc: Date {
        expirationDate ?? .distantPast
    }

    public static let mock: PurchasedEntitlement = PurchasedEntitlement(
        id: UUID().uuidString,
        productId: "my.product.id",
        expirationDate: Date().addingTimeInterval(7 * 24 * 60 * 60),
        isActive: true,
        originalPurchaseDate: .now,
        latestPurchaseDate: .now,
        ownershipType: .purchased,
        isSandbox: true,
        isVerified: true
    )
    
    public enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case expirationDate = "expiration_date"
        case isActive = "is_active"
        case originalPurchaseDate = "original_purchase_date"
        case latestPurchaseDate = "latest_purchase_date"
        case ownershipType = "ownership_type"
        case isSandbox = "is_sandbox"
        case isVerified = "is_verified"
    }

    public var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "entitlement_\(CodingKeys.id.rawValue)": id,
            "entitlement_\(CodingKeys.productId.rawValue)": productId,
            "entitlement_\(CodingKeys.expirationDate.rawValue)": expirationDate,
            "entitlement_\(CodingKeys.isActive.rawValue)": isActive,
            "entitlement_\(CodingKeys.originalPurchaseDate.rawValue)": originalPurchaseDate,
            "entitlement_\(CodingKeys.latestPurchaseDate.rawValue)": latestPurchaseDate,
            "entitlement_\(CodingKeys.ownershipType.rawValue)": ownershipType,
            "entitlement_\(CodingKeys.isSandbox.rawValue)": isSandbox,
            "entitlement_\(CodingKeys.isVerified.rawValue)": isVerified
        ]
        return dict.compactMapValues({ $0 })
    }
}
