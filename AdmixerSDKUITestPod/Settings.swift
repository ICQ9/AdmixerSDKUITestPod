//
//  Settings.swift
//  IOSSampleApp
//
//  Created by Dima on 10.02.2021.
//

import Foundation
import UIKit




class Settings: UIViewController  {
    var autorefresh: Bool = true
    var resize100set: Bool = false
    var delay: Bool = false
    @IBOutlet var gotoxml: UIButton!
    @IBOutlet var gotolist: UIView!
    var expandtofit: Bool = false
    var reload: Bool = false
    @IBOutlet weak var Reload: UISwitch!
    @IBOutlet weak var ExpandToFit: UISwitch!
    @IBOutlet weak var Resize: UISwitch!
    @IBOutlet weak var Autorefresh: UISwitch!
    @IBOutlet weak var Delay: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func ExpandToFit(_ sender: UISwitch){
        if ExpandToFit.isOn{
            expandtofit = true
        } else{expandtofit = false}
    }
    
    @IBAction func Reload(_ sender: UISwitch){
        if  Reload.isOn{
            reload = true
            Autorefresh.isOn = false
            Autorefresh.isEnabled = false
            autorefresh = false
        } else {
            reload = false
            Autorefresh.isEnabled = true
            
        }
    }
    
    @IBAction func Autorefresh(_ sender: UISwitch){
        if Autorefresh.isOn{
            autorefresh = true
        }
        else{ autorefresh = false}
    }
    
    
    @IBAction func Delay5sek(_ sender: UISwitch) {
        if sender.isOn{
            delay=true
        }
        else{delay = false}
        
    }
    @IBAction func resizeDidChange(_ sender: UISwitch){
        if sender.isOn{
            resize100set = true
            }
        
        else{ resize100set = false
            }

            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoxml"{
        let destenationXML: BannerXML = segue.destination as! BannerXML
        
        destenationXML.resize100 = resize100set
        destenationXML.delayresult = delay
        destenationXML.expandtofitresult = expandtofit
        destenationXML.reloadresult = reload
        destenationXML.autorefreshresult = autorefresh
        }
            if segue.identifier == "gotolist"{
                let destenationList:BannerInLine = segue.destination as! BannerInLine
                
                destenationList.resize100local = resize100set
                destenationList.expantToFitLocal = expandtofit
                destenationList.reloadlocalresult = reload
                destenationList.autorefreshlocalresult = autorefresh
                destenationList.delaylocalresult = delay
                
                
            }
        if segue.identifier == "gotocode"{
            let destenationCode:BannerInCode = segue.destination as! BannerInCode
            
            destenationCode.resize100code = resize100set
            destenationCode.expandtofitresultcode = expandtofit
            destenationCode.reloadresultcode = reload
            destenationCode.autorefreshresultcode = autorefresh
            destenationCode.delayresultcode = delay
        }
            
        }
    }
   
        
    
    
        
    
    

    
    



