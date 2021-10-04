//
//  InStreamViewController.swift
//  IOSSampleApp
//
//  Created by Admixer DEV on 09.09.2021.
//

import Foundation
import AdmixerSDK
import UIKit

enum InstreamModes {
    case inpage
    case fulscreen
}


class InStreamViewController: UIViewController,AMAdDelegate{
    
    @IBOutlet weak var CustomSkipText: UITextField!
    @IBOutlet weak var CustomLinkText: UITextField!
    @IBOutlet weak var FullscreenMode: UISwitch!
    @IBOutlet weak var LoadButton: UIButton!
    @IBOutlet weak var player: UIView!
    @IBOutlet var InstreamConstant: [UIButton]!
    @IBOutlet var ShowSwitch: [UISwitch]!
    @IBOutlet var SwitchesText: [UILabel]!
    private var instreamAd: AMInstreamVideoAd?
    private var mode: InstreamModes = .inpage
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        AMVideoPlayerSettings.sharedInstance.showSkip = false
        AMVideoPlayerSettings.sharedInstance.showVolumeControl = false
        AMVideoPlayerSettings.sharedInstance.showClickThruControl = false
        //TODO
    }
    

        
    @IBAction func LoadInstream(_ sender: UIButton) {
        player.isHidden = false
        
        if FullscreenMode.isOn{
            mode = .fulscreen
        }
        else{
            mode = .inpage
        }
        
        if mode == .inpage{
            instreamAd = AMInstreamVideoAd(placementId: "c744a785-272b-4b85-8a93-5eb581d74565")
            instreamAd?.clickThroughAction = .openSDKBrowser
            instreamAd?.loadAd(with: self)
        }
        
        let link_text = CustomLinkText.text ?? ""
        if !link_text.isEmpty{
            AMVideoPlayerSettings.sharedInstance.learnMoreLabelName = link_text
        }
        
        let skip_text = CustomSkipText.text ?? ""
        if !link_text.isEmpty{
            AMVideoPlayerSettings.sharedInstance.skipLabelName = skip_text
        }
        
        if ShowSwitch[2].isOn{
            AMVideoPlayerSettings.sharedInstance.showVolumeControl = true
        }
        if ShowSwitch[1].isOn{
            AMVideoPlayerSettings.sharedInstance.showClickThruControl = true
        }
        
        if ShowSwitch[0].isOn{
            AMVideoPlayerSettings.sharedInstance.showSkip = true
        }
        
        
        for text in SwitchesText{
            text.isHidden = true
        }
        
        for switches in ShowSwitch{
            switches.isHidden = true
        }
        
        for button in InstreamConstant{
            button.isHidden = false
        }
        
        
    }
    
    public func playInstreamFullscreen(){
        
    }
    
    public func playInstreamInPage(){
        self.instreamAd?.play(withContainer: player, with: self)
    }
    
    
    @IBAction func ShowMute(_ sender: Any) {
        instreamAd?.showVolumeControl()
    }
    
    @IBAction func HideMute(_ sender: Any) {
        instreamAd?.hideVolumeControl()
    }
    
    @IBAction func ShowLink(_ sender: Any) {
        instreamAd?.showClickThruControl()
    }
    
    @IBAction func HideLink(_ sender: Any) {
        instreamAd?.hideClickThruControl()
    }
    
    @IBAction func ShowSkip(_ sender: Any) {
        instreamAd?.showSkip()
    }
    
    @IBAction func HideSkip(_ sender: Any) {
        instreamAd?.hideSkip()
    }

}


extension InStreamViewController: AMInstreamVideoAdLoadDelegate{
    func adDidReceiveAd(_ ad: Any) {
        print("MyLog width: \(instreamAd?.getCreativeWidth()) height:\(instreamAd?.getCreativeHeight())")
        
        if mode == .fulscreen{
            playInstreamFullscreen()
        }
        else{
            playInstreamInPage()
        }
    }
    
    func ad(_ ad:Any, requestFailedWithError error: Error){
        print("MyLog \(error)")
    }
}

extension InStreamViewController: AMInstreamVideoAdPlayDelegate{
    func adDidComplete(_ ad: AMAdView) {
        print("Video END")
        
        for button in InstreamConstant {
            button.isHidden = true
        }
        
        for switches in ShowSwitch{
            switches.isHidden = false
        }
        
        for text in SwitchesText{
            text.isHidden = false
        }
        
        player.isHidden = true
    }
}

