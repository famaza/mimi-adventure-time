//
//  InAppPurchaseManager.swift
//  Mimi
//
//  Created by Federico Maza on 17/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

import StoreKit

class InAppPurchaseManager: NSObject {
    
    // MARK: Properties

    lazy var products: [SKProduct] = []

    let paymentQueue: SKPaymentQueue
    
    // MARK: Shared Instance
    
    static let shared = InAppPurchaseManager()
    
    // MARK: Initialization
    
    private override init() {
        
        // Keep a local reference to the default payment queue.
        self.paymentQueue = SKPaymentQueue.default()
        
    }
    
    // MARK: Methods
    
    func startProductsRequest() {
        
        // Register this class as a payment transaction observer.
        paymentQueue.add(self)
        
        // Create a set with the identifiers of the products to request.
        var products: Set<String> = []
        
        products.insert(InAppPurchaseProduct.cookies.rawValue)
        
        products.insert(InAppPurchaseProduct.unlimitedCookies.rawValue)
        
        // Initialize a products request with the given set.
        let request = SKProductsRequest(productIdentifiers: products)
        
        request.delegate = self
        
        // Send the request to the App Store.
        request.start()
        
    }
    
    // TODO: Add parental controls checks.
    
    func purchase(product: InAppPurchaseProduct) {
        
        guard let choice = products.filter({element in element.productIdentifier == product.rawValue }).first else {
            
            return
            
        }
        
        let payment = SKPayment(product: choice)
        
        // Submit the payment request to the payment queue.
        paymentQueue.add(payment)
        
    }
    
    func restorePurchases() {
        
        // Restore completed transactions.
        paymentQueue.restoreCompletedTransactions()
        
    }
    
    func deliverPurchased(_ product: InAppPurchaseProduct) {

        // TODO: Loop through the product inventory to deliver the purchase item to the user.
    
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        for transaction in queue.transactions {
            
            switch transaction.transactionState {
                
                // Deliver the product to the user when the transaction has been restored.
                case .restored:
                
                    if let product = InAppPurchaseProduct(rawValue: transaction.payment.productIdentifier) {
                        
                        deliverPurchased(product)
                        
                        paymentQueue.finishTransaction(transaction)
                        
                    }
                
                default: break
                
            }
            
        }
        
    }
    
}

extension InAppPurchaseManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        self.products = response.products
        
    }
    
}

extension InAppPurchaseManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
                // Deliver the product to the user when the transaction's state is purchased or restored.
                case .purchased, .restored:
                    
                    if let product = InAppPurchaseProduct(rawValue: transaction.payment.productIdentifier) {
                        
                        deliverPurchased(product)
                        
                        paymentQueue.finishTransaction(transaction)
                        
                    }
                            
                // Force the termination of the transaction in the queue.
                default: paymentQueue.finishTransaction(transaction)
                
            }
            
        }
        
    }
    
}
