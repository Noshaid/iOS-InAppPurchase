//
//  UpGradeViewController.swift
//  InAppPurchase
//
//  Created by Noshaid Ali on 14/05/2021.
//

import UIKit
import StoreKit

class UpGradeViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    var myProduct: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProducts()
    }
    
    func fetchProducts() {
        //com.cricingif.test.removeads
        let request = SKProductsRequest(productIdentifiers:["com.cricingif.test.removeads"])
        request.delegate = self
        request.start()
    }
    
    @IBAction func didTapBuy(_ sender: Any) {
        guard let myProduct = myProduct else {
            return
        }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error)
        print(error.localizedDescription)
    }
    //called when product request receive
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            myProduct = product
            print(product.productIdentifier)
            print(product.price)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.priceLocale)
        }
    }
    
    //called when you inisiated transaction
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    // no op
                    break
                case .purchased, .restored:
                    //unlocked their item
                    
                    UserDefaults.standard.set(true, forKey: "ads_removed")
                    
                    SKPaymentQueue.default().finishTransaction(transaction)
                    SKPaymentQueue.default().remove(self)
                    break
                case .failed, .deferred:
                    SKPaymentQueue.default().finishTransaction(transaction)
                    SKPaymentQueue.default().remove(self)
                    break
                default:
                    SKPaymentQueue.default().finishTransaction(transaction)
                    SKPaymentQueue.default().remove(self)
                    break
            }
        }
    }
}
