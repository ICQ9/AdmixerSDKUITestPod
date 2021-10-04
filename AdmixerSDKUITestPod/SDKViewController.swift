//
//  SDKViewController.swift
//  IOSSampleApp
//
//  Created by Dima on 05.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK
import CoreLocation
import Dispatch
import AVKit
import AVFoundation

enum InstreamMode{
    case fullscreen
    case in_layer
}


class SDKViewController: UIViewController, AMAdDelegate{
    @IBOutlet weak var VideoTypes: UISegmentedControl!
    @IBOutlet weak var BannerView: UIView!
    private var interstitialAd: AMInterstitialAd?
    private var banner: AMBannerAdView?
    private var instreamAd: AMInstreamVideoAd?
    private let videoURL = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")
    private var playerViewController: AVPlayerViewController?
    private var locationManager: CLLocationManager!
    @IBOutlet var placementId: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var width: UITextField!
    private var rewarded: AMRewardedAd?
    private var mode: InstreamMode = .in_layer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AMLogLevel.currentLevel = .all
        AMGDPRSettings.setConsentRequired(0)
        AMGDPRSettings.setConsentString("abc")
    }
    // MARK: Banner
    @IBAction func Load_Banner(_ sender: Any) {
        self.view.endEditing(true)
        stopAll()
        loadBanner()
        //Some changes
    }
    // MARK: Interstitial
    @IBAction func LoadInter(_ sender: Any) {
        self.view.endEditing(true)
        stopAll()
        showInterstitial()
        
    }
    // MARK: Rewarded
    @IBAction func LoadRevarded(_ sender: Any) {
        self.view.endEditing(true)
        stopAll()
        showRewarded()
    }
    
    // MARK: Instream
    @IBAction func LoadInstream(_ sender: Any) {
        self.view.endEditing(true)
        if self.VideoTypes.selectedSegmentIndex == 0 {//in_page
            stopAll()
            loadInstreamInLayer()
            mode = .in_layer
        }
        
        if self.VideoTypes.selectedSegmentIndex == 1 {
            stopAll()
            loadInstreamFullscreen()
            mode = .fullscreen
        }

    }
    
    // MARK: Load Rewarded
    func showRewarded(){
        let id = placementId.text ?? ""
        if id.isEmpty{
            self.showEror("Empty PlacementId")
            return
        }
        
        self.rewarded = AMRewardedAd(placementId: id)
        self.rewarded?.clickThroughAction = .openSDKBrowser
        self.rewarded?.delegate = self
        self.rewarded?.loadAd()
    }
    // MARK: Load Instrema in Fullscreen
    private func loadInstreamFullscreen(){
        let id = placementId.text ?? ""
        if id.isEmpty{
            self.showEror("Empty PlacementId")
            return
        }
        
        playerViewController = AVPlayerViewController()
        playerViewController?.showsPlaybackControls = false
        if let player = playerViewController{
            self.present(player, animated: true, completion: nil)
        }
        
        instreamAd = AMInstreamVideoAd(placementId: id)
        instreamAd?.loadAd(with: self)
    }
    // MARK: Loader Instream In Layer
    private func loadInstreamInLayer(){
        let id = placementId.text ?? ""
        if id.isEmpty{
            self.showEror("Empty PlacementId")
            return
        }
        
        instreamAd = AMInstreamVideoAd(placementId: id)
        instreamAd?.loadAd(with: self)
    }
    // MARK: Play Instream in FullScrenn
    private func playInstreamFullScreen(){
        self.instreamAd?.play(withContainer: (self.playerViewController?.contentOverlayView)!, with: self)
        
    }
    // MARK: PlayInstream In Layer
    private func playInstreamInLayer(){
        self.instreamAd?.play(withContainer: BannerView, with: self)
    }
    // MARK:  Play Video in Layer
    private func playVideoInLayer(){
        let player = AVPlayer(url: videoURL!)
        player.actionAtItemEnd = .none
        
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.frame = BannerView.bounds
        videoLayer.videoGravity = .resizeAspect
        BannerView.layer.addSublayer(videoLayer)
        
        player.play()
    }
    // MARK: PlayVideo InVideo Controller
    private func playVideoInVideoController(){
        let player = AVPlayer(url: videoURL!)
        player.actionAtItemEnd = .none
        
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.frame = self.playerViewController?.contentOverlayView?.bounds ?? CGRect(x: 0, y: 0, width: 300, height: 169)
        videoLayer.videoGravity = .resizeAspect
        self.playerViewController?.contentOverlayView?.layer.addSublayer(videoLayer)
        
        player.play()
    }
    
    
    @IBAction func LoadNative(_ sender: Any) {
        showEror("Module in Work")

        //TODO: Create Native Loader
    }
    // MARK: Stop All Function
    private func stopAll(){
        if let banner = self.banner{
        banner.removeFromSuperview()
        banner.delegate = nil
        self.banner = nil
        }
        
        if let interstitialAd = self.interstitialAd{
            interstitialAd.removeFromSuperview()
            interstitialAd.delegate = nil
            self.interstitialAd = nil
        }
        if let instream = self.instreamAd{
            instream.removeFromSuperview()
            instream.delegate = nil
            self.instreamAd = nil
        }
        if let rewarded = self.rewarded{
            rewarded.removeFromSuperview()
            rewarded.delegate = nil
            self.rewarded = nil
        }
    }
    // MARK: Show Error Function
    private func showEror(_ msg:String){
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: Banner
    private func loadBanner(){
        let id = placementId.text ?? ""
        if id.isEmpty{
            self.showEror("Empty Ad Unit Id")
        }
        let w = width.text ?? ""
        let h = height.text ?? ""
        var wint = Int(w) ?? 0
        if wint == 0{
            wint = 300
        }
        var hint = Int(h) ?? 0
        if hint == 0{
            hint = 250
        }
        let adSize = CGSize(width: wint, height: hint)
        let bannerSize = CGSize(width: BannerView.frame.size.width, height: BannerView.frame.size.height)
        let origin = CGPoint(x:0, y:0)
        let adRect = CGRect(origin: origin, size: adSize)
        let banner = AMBannerAdView(frame: adRect, placementId: id, adSize: adSize)
        banner.shouldResizeAdToFitContainer = true
        banner.rootViewController = self
        banner.delegate = self
        banner.clickThroughAction = .openSDKBrowser
        self.view.addSubview(banner)
        banner.shouldServePublicServiceAnnouncements = true
        //AMLogLevel.currentLevel = .debug
        banner.autoRefreshInterval = 15
        banner.loadAd()
        self.banner = banner
        BannerView.addSubview(banner)
        locationSetup()
        
    }
    
    // MARK: Interstitial
    
    func showInterstitial(){
        let id = placementId.text ?? ""
        if id.isEmpty{
            self.showEror("Empty Ad Unit Id")
        }
        let interstitialAd = AMInterstitialAd(placementId: id)
        interstitialAd.delegate = self
        interstitialAd.loadAd();
        self.interstitialAd = interstitialAd
    }
    
    // MARK: Location Setup
    private func locationSetup(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
}
      
    // MARK: Extensions

extension SDKViewController: AMInstreamVideoAdLoadDelegate, AMRewardedAdDelegate{
    func adDidReceiveAd(_ ad: Any) {
        if let instreamAd = instreamAd {
            if mode == .fullscreen{
                playInstreamFullScreen()
            } else {
                playInstreamInLayer()
            }
        }
        self.rewarded?.display(from: self)
        
        self.interstitialAd?.display(from: self)
}
    func ad(_ ad: Any, requestFailedWithError error: Error){
        
    }
}

extension SDKViewController : AMInstreamVideoAdPlayDelegate{
    func adDidComplete(_ ad: AMAdView){
        if mode == .fullscreen{
            playVideoInVideoController()
        }else {
            playVideoInLayer()
        }
    }
}

    extension SDKViewController: AMInterstitialAdDelegate{
        
        func adinter(_ ad:Any,requestFailedWithError error:Error){
            self.showEror("Ad failed to load\(error.localizedDescription)")
        }
    }
    
    extension SDKViewController: AMBannerAdViewDelegate{
        func adHaveError(_ ad:Any, requestFailedWithError error: Error){
            self.showEror("Ad failed to lodad\(error.localizedDescription)")
        }
    }
    
    extension SDKViewController: CLLocationManagerDelegate{
        func locationManager(_ manager: CLLocationManager,didUpdateLocations locations:[CLLocation]){
            guard let location = locations.last else {return}
            let lat = CGFloat(location.coordinate.latitude)
            let long = CGFloat(location.coordinate.longitude)
            let acc = CGFloat(location.horizontalAccuracy)
            let anLocations = AMLocation.getWithLatitude(lat, longitude: long, timestamp: location.timestamp, horizontalAccuracy: acc)
            self.banner?.location = anLocations
        }
    }

    
