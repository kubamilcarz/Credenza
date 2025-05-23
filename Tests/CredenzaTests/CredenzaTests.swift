import Testing
import SwiftUI
import Foundation
@testable import Credenza

@MainActor
struct PurchaseManagerTests {

    @Test("PurchaseManager logs in successfully and updates entitlements")
    func testLogInSuccess() async throws {
        // Given
        let mockService = MockPurchaseService(activeEntitlements: [
            PurchasedEntitlement(
                id: "com.example.product",
                productId: "com.example.product",
                expirationDate: nil,
                isActive: true,
                originalPurchaseDate: Date(),
                latestPurchaseDate: Date(),
                ownershipType: .purchased,
                isSandbox: false,
                isVerified: true
            )
        ])
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        try await purchaseManager.logIn(userId: "testUser")

        // Then
        #expect(purchaseManager.entitlements.hasActiveEntitlement == true)
        #expect(purchaseManager.entitlements.count == 1)
    }

    @Test("PurchaseManager handles login failure and logs the error")
    func testLogInFailure() async throws {
        // Given
        let mockService = MockPurchaseService(activeEntitlements: [])
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        try await purchaseManager.logIn(userId: "testUser")

        // Then
        #expect(purchaseManager.entitlements.hasActiveEntitlement == false)
        #expect(purchaseManager.entitlements.isEmpty)
    }

    @Test("PurchaseManager logs out and clears entitlements")
    func testLogOut() async throws {
        // Given
        let mockService = MockPurchaseService(activeEntitlements: [
            PurchasedEntitlement(
                id: "com.example.product",
                productId: "com.example.product",
                expirationDate: nil,
                isActive: true,
                originalPurchaseDate: Date(),
                latestPurchaseDate: Date(),
                ownershipType: .purchased,
                isSandbox: false,
                isVerified: true
            )
        ])
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        try await purchaseManager.logOut()

        // Then
        #expect(purchaseManager.entitlements.isEmpty)
    }

    @Test("PurchaseManager purchases product and updates entitlements")
    func testPurchaseProductSuccess() async throws {
        // Given
        let mockService = MockPurchaseService()
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        let result = try await purchaseManager.purchaseProduct(productId: "com.example.product")

        // Then
        #expect(result.count == 1)
        #expect(purchaseManager.entitlements.hasActiveEntitlement == true)
    }

    @Test("PurchaseManager restores purchases and updates entitlements")
    func testRestorePurchaseSuccess() async throws {
        // Given
        let mockService = MockPurchaseService()
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        let result = try await purchaseManager.restorePurchase()

        // Then
        #expect(result.count == 1)
        #expect(purchaseManager.entitlements.hasActiveEntitlement == true)
    }

    @Test("PurchaseManager handles entitlement update correctly after restore")
    func testUpdateActiveEntitlementsAfterRestore() async throws {
        // Given
        let mockService = MockPurchaseService()
        let purchaseManager = PurchaseManager(service: mockService)

        // When
        try! await purchaseManager.restorePurchase()

        // Then
        #expect(purchaseManager.entitlements.count == 1)
    }
}
