//
//  BannerInCode.swift
//  IOSSampleApp
//
//  Created by Dima on 08.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK



class BannerInCode:UIViewController{
    @IBOutlet weak var BannerViewCode: UIView!
    var resize100code: Bool?
    var delayresultcode: Bool?
    var reloadresultcode: Bool?
    var expandtofitresultcode: Bool?
    var autorefreshresultcode: Bool?
    var banner: AMBannerAdView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if delayresultcode == true{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: loadBanner)
        }
        else { loadBanner()}
        
            
    }
    
    func loadBanner(){
        print("height: \(BannerViewCode.frame.size.height)")
        let origin = CGPoint(x: 0, y:0)
    if (resize100code == true){
        BannerViewCode.frame.size.width = 100
        BannerViewCode.frame.size.width = 100
        
    }
    if (expandtofitresultcode == true){
        BannerViewCode.frame.size.width = self.view.frame.size.width
        }
    let bannerSize = CGSize(width:BannerViewCode.frame.size.width, height:BannerViewCode.frame.size.height)
    let bannerFrame = CGRect(origin:origin,size:bannerSize)
    let adSize = CGSize(width:300, height:250)
    let banner = AMBannerAdView(frame: bannerFrame, placementId:"f9a26255-08a2-40ec-9667-3ab35e69625a", adSize: adSize)
    
    banner.autoresizesSubviews = true
    banner.shouldResizeAdToFitContainer = true
        if autorefreshresultcode == true{
            banner.autoRefreshInterval = 30
        }
        else {banner.autoRefreshInterval = 0}

    banner.rootViewController = self
    banner.loadAd()
    self.banner = banner
    BannerViewCode.addSubview(banner)
    }
}
