//
//  BannerXML.swift
//  IOSSampleApp
//
//  Created by Dima on 08.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK
import Dispatch



class BannerXML:UIViewController{
    @IBOutlet weak var BannerView: UIView!
    var resize100: Bool?
    var delayresult: Bool?
    var reloadresult: Bool?
    var expandtofitresult: Bool?
    var autorefreshresult: Bool?
    var banner: AMBannerAdView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if delayresult == true{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: loadBanner)
        }
        else { loadBanner()}
        
            
    }
    
    func loadBanner(){
        print("height: \(BannerView.frame.size.height)")
        let origin = CGPoint(x: 0, y:0)
    if (resize100 == true){
        BannerView.frame.size.width = 100
        BannerView.frame.size.width = 100
        
    }
    if (expandtofitresult == true){
        BannerView.frame.size.width = self.view.frame.size.width
        }
    let bannerSize = CGSize(width:BannerView.frame.size.width, height:BannerView.frame.size.height)
    let bannerFrame = CGRect(origin:origin,size:bannerSize)
    let adSize = CGSize(width:300, height:250)
    let banner = AMBannerAdView(frame: bannerFrame, placementId:"f9a26255-08a2-40ec-9667-3ab35e69625a", adSize: adSize)
    
    banner.autoresizesSubviews = true
    banner.shouldResizeAdToFitContainer = true
        if autorefreshresult == true{
            banner.autoRefreshInterval = 30
        }
        else {banner.autoRefreshInterval = 0}

    banner.rootViewController = self
    banner.loadAd()
    self.banner = banner
    BannerView.addSubview(banner)
    }
    
   
        
}

