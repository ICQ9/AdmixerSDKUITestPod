//
//  MediationViewController.swift
//  IOSSampleApp
//
//  Created by Dima on 05.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK
import GoogleMobileAds
import CoreLocation

class MediationViewController:UIViewController{
    @IBOutlet weak var placement_id: UITextField!
    private var adMobBanner: GADBannerView?
    // AdMob 7.69
//    private var adMobInterstitial: GADInterstitial?
    // AdMob 8.0
    private var adMobInterstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func LoadAdMob_Banner(_ sender: Any) {
        stopAll()
        loadAdMobBanner()
    }
    @IBAction func LoadAdMob_Inter(_ sender: Any) {
        stopAll()
        loadAdMobInter()
    }
    
    
    private func stopAll(){
        if let adMobBanner = self.adMobBanner{
            adMobBanner.removeFromSuperview()
            adMobBanner.delegate = nil
            self.adMobBanner = nil
        
        }
        if let adMobInterstitial = self.adMobInterstitial{
            // AdMob 7.69
//            adMobInterstitial.delegate = nil
            // AdMob 8.0
            adMobInterstitial.fullScreenContentDelegate = nil
            self.adMobInterstitial = nil
        }
        
    }
        func showEror(_ msg:String){
            let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        }
    func loadAdMobInter(){
        let id = placement_id.text ?? ""
        if id.isEmpty{
            self.showEror("Empty Ad Unit Id")
        }
        // AdMob 7/69
//        let adMobInterstitial = GADInterstitial(adUnitID: id)
//        adMobInterstitial.delegate = self
//        adMobInterstitial.load(GADRequest())
//        self.adMobInterstitial = adMobInterstitial
        // AdMob 8.0
        GADInterstitialAd.load(withAdUnitID: id, request: GADRequest()) { (ad, error) in
            if let error = error {
                return
            }
            self.adMobInterstitial = ad
            self.adMobInterstitial?.present(fromRootViewController: self)
        }
    }
        
        func loadAdMobBanner(){
            let id = placement_id.text ?? ""
            if id.isEmpty{
                self.showEror("Empty Ad Unit Id")
            }
            
            let adSize = CGSize(width: 300, height: 250)
            let bannerSize = CGSize(width: 300, height: 250)
            let bannerOrigin = CGPoint(x: 50, y: 400)
            let bannerRect = CGRect(origin: bannerOrigin, size: adSize)
            var gadSize: GADAdSize
            gadSize = GADAdSizeFromCGSize(adSize)

            let adMobBanner = GADBannerView(adSize: gadSize)
            adMobBanner.frame = bannerRect
            adMobBanner.adUnitID = id
            adMobBanner.rootViewController = self
            adMobBanner.delegate = self
            self.view.addSubview(adMobBanner)
            
            adMobBanner.load(GADRequest())
            self.adMobBanner = adMobBanner
        }
    }
        // AdMob 7.69
//extension MediationViewController: GADInterstitialDelegate{
//    func interstitialDidReceiveAd(_ ad: GADInterstitial){
//        adMobInterstitial?.present(fromRootViewController: self)
//    }
//}
extension MediationViewController: GADBannerViewDelegate{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Demo AdMob ad Loaded")
        self.view.addSubview(bannerView)
    }
}

    

