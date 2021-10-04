//
//  BannerInLine.swift
//  IOSSampleApp
//
//  Created by Dima on 08.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK
import Dispatch


class BannerInLine:UITableViewController{
    var banner: AMBannerAdView?
    var delaylocalresult: Bool?
    var expantToFitLocal: Bool?
    var reloadlocalresult: Bool?
    var autorefreshlocalresult: Bool?
    var resize100local: Bool?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 50
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?{
        let text_Title = "HelloWorld"
        return text_Title
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell
        else {
            fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        
        cell.itemLabel.text = "Hello \(indexPath.item)"
        
        
        if reloadlocalresult == true{
            if (banner == nil){
            
            let origin = CGPoint(x: 0, y:0)
                
                if resize100local == true{
                    cell.BannerView.frame.size.width = 100
                    cell.BannerView.frame.size.height = 100

                }
                if expantToFitLocal == true{
                    cell.BannerView.frame.size.width = self.view.frame.size.width
                }
                let bannerSize = CGSize(width:cell.BannerView.frame.size.width, height:cell.BannerView.frame.size.height)
            let bannerFrame = CGRect(origin:origin,size:bannerSize)
            let adSize = CGSize(width:300, height:250)
            let banner = AMBannerAdView(frame: bannerFrame, placementId:"f9a26255-08a2-40ec-9667-3ab35e69625a", adSize: adSize)
                banner.autoresizesSubviews = true
                banner.shouldResizeAdToFitContainer = true
                if autorefreshlocalresult == true{
            banner.autoRefreshInterval = 30
                }
                else{banner.autoRefreshInterval = 0}
            banner.rootViewController = self
                if delaylocalresult == true{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: banner.loadAd)
                }
                else {
                    banner.loadAd()
                }
            self.banner = banner
            
            cell.BannerView.addSubview(banner)
                
            }
        }
        
        if reloadlocalresult == false {
            let origin = CGPoint(x: 0, y: 0)
            if resize100local == true{
                cell.BannerView.frame.size.width = 100
                cell.BannerView.frame.size.height = 100

            }
            if expantToFitLocal == true{
                cell.BannerView.frame.size.width = self.view.frame.size.width
            }
            let bannerSize = CGSize(width:cell.BannerView.frame.size.width, height:cell.BannerView.frame.size.height)
        let bannerFrame = CGRect(origin:origin,size:bannerSize)
        let adSize = CGSize(width:300, height:250)
        let banner = AMBannerAdView(frame: bannerFrame, placementId:"f9a26255-08a2-40ec-9667-3ab35e69625a", adSize: adSize)
            banner.autoresizesSubviews = true
            banner.shouldResizeAdToFitContainer = true
            if autorefreshlocalresult == true{
        banner.autoRefreshInterval = 30
            }
            else{banner.autoRefreshInterval = 0}
        banner.rootViewController = self
            if delaylocalresult == true{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: banner.loadAd)
            }
            else {
                banner.loadAd()
            }
        self.banner = banner
        
        cell.BannerView.addSubview(banner)
            
        }
        return cell
            
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
         
    }

}
extension BannerInLine: AMBannerAdViewDelegate{
    func adDidClose(_ ad: Any) {
        print ("Ad did close")
    }
    func adWasClicked(_ ad: Any) {
        print("Ad was clicked")
    }
    func adWasClicked(_ ad: AMAdView, withURL urlString: String) {
        print("ClickThroughUrl=\(urlString)")
    }
    
    func ad(_ ad:Any, requestFailedWithError error: Error){
    }
}

 
