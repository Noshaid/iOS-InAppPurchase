//
//  ViewController.swift
//  InAppPurchase
//
//  Created by Noshaid Ali on 14/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !UserDefaults.standard.bool(forKey: "ads_removed") {
            //show ads
        } else {
            //remove ads
        }
    }


    @IBAction func didTapRemoveAds() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "upgrade") else {
            return
        }
        vc.title = "Remove Ads"
        navigationController?.pushViewController(vc, animated: true)
    }
}

