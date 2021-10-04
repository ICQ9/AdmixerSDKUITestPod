//
//  AdmixerSDKUITestPodUITests.swift
//  AdmixerSDKUITestPodUITests
//
//  Created by MacBookPro on 04.10.2021.
//

import XCTest

class AdmixerSDKUITestPodUITests: XCTestCase {
    
    

    override func setUpWithError() throws {
        
        continueAfterFailure = false
            
        
        
    }

    override func tearDownWithError() throws {
        
    }
    
    

    func testInterstitialFullscreenUiRender() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("e94817ae-5d00-4d2a-98d7-5e9600f55ad6")
        app.buttons["Load Interstitial"].tap()
        
        XCTAssertTrue(app.otherElements.element(boundBy: 14).waitForExistence(timeout: 10),"Interstitial not exist")
        
        if app.otherElements.element(boundBy: 14).exists{
            XCTAssertTrue(true,"Interstitial exist")
            sleep(2)
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
        }
        else{
            print("Interstitial not Exist")
            XCTAssertFalse(false, "Interstitial not exist")
        }

    }
    
    func testinterstitialClick() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("e94817ae-5d00-4d2a-98d7-5e9600f55ad6")
        app.buttons["Load Interstitial"].tap()
        
        XCTAssertTrue(app.otherElements.element(boundBy: 14).waitForExistence(timeout: 10),"Interstitial not exist")
        
        if app.otherElements.element(boundBy: 14).exists{
            let banner = app.otherElements.element(boundBy: 14)
            XCTAssertTrue(true,"Interstitial exist")
            sleep(2)
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
            banner.tap()
            sleep(5)
            XCTAssert(app.buttons["OK"].exists, "Browser Exist")
            
            if app.buttons["OK"].exists{
                print("Browser Exist")
                sleep(1)
                let fullscreen = XCUIScreen.main.screenshot()
                let screen = XCTAttachment(screenshot: fullscreen)
                screen.lifetime = .keepAlways
                add(screen)
                app.buttons["OK"].tap()
            }
            else {
                print("Browser not exist")
            }
        }
        else{
            print("Interstitial not Exist")
            XCTAssertFalse(false, "Interstitial not exist")
        }
    }
    
    func testInterstitialBeforeLockScreen() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("e94817ae-5d00-4d2a-98d7-5e9600f55ad6")
        app.buttons["Load Interstitial"].tap()
        
        XCTAssertTrue(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10),"Interstitial not Exist")
        
        if app.webViews.element(boundBy: 2).exists{
            print("Interstitial Exist")
            sleep(1)
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
            
            XCUIDevice.shared.perform(NSSelectorFromString("pressLockButton"))
            sleep(2)
            
        }
    }
    
    
    func testInterstitialClickCloseButton() throws{
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("f9a26255-08a2-40ec-9667-3ab35e69625a")
        app.buttons["Load Interstitial"].tap()
        
        XCTAssertTrue(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10),"Interstitial not exist")
            
        if app.webViews.element(boundBy: 2).exists{
            let banner = app.webViews.element(boundBy: 2)
            print("Interstitial Exist")
            sleep(1)
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
//            let cord = banner.coordinate(withNormalizedOffset: CGVector(dx: 381, dy: 54))
//            cord.tap()
            if app.buttons.element(boundBy: 0).exists{
                app.buttons.element(boundBy: 0).tap()
                XCTAssert(true,"Close button exist")
                sleep(4)
            }
            else{
                XCTAssert(false,"Close Button not exist")
            }
            let fullscreen2 = XCUIScreen.main.screenshot()
            let screen2 = XCTAttachment(screenshot: fullscreen2)
            screen2.lifetime = .keepAlways
            add(screen2)
        }
        else{
            XCTAssert(false,"Interstitial not exist")
            print("Interstitial not exist")
        }
        
    }
    
    func testBannerUiRender() throws{
        let app = XCUIApplication()
        app.launch()
        //print(app.otherElements.allElementsBoundByIndex)
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("f9a26255-08a2-40ec-9667-3ab35e69625a")
        app.buttons["Load Banner"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10), "Banner is Displayed")
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        if app.webViews.element(boundBy: 2).exists{
            let banner = app.webViews.element(boundBy: 2)
            XCTAssertTrue(banner.exists)
            XCTAssertTrue(app.buttons["Load Banner"].exists)
            XCTAssertEqual(banner.frame.size.width,300)
            XCTAssertEqual(banner.frame.size.height, 250)
            XCTAssertTrue(true,"Banner is Displayed ")
        }
        else{
            XCTAssertFalse(false, "Banner not returned")
        }
    }
    
    func testBannerClick() throws{
        let app = XCUIApplication()
        app.launch()
//        print(app.webViews.allElementsBoundByIndex)
        let banner_adview = app.otherElements["bannerView"]
        let load_ad_button = app.buttons.element(boundBy: 5)
        let placement_text_field = app.textFields.element(boundBy: 0)
        placement_text_field.tap()
        placement_text_field.typeText("f9a26255-08a2-40ec-9667-3ab35e69625a")
        load_ad_button.tap()
        //print(app.webViews.allElementsBoundByIndex)
        XCTAssertTrue(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        if app.webViews.element(boundBy: 2).exists{
            print("Element Have Displayed")
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
            XCTAssert(true, "Banner is Displayed")
            let banner = app.webViews.element(boundBy: 2)
            sleep(2)
            banner.tap()
        }
        else{
            print("Element Not Displayed")
            XCTAssertFalse(false, "Banner is not Displayed")
        }
//        let banner = app.webViews.element(boundBy: 5)
//        if banner.accessibilityElementsHidden{
//            XCTAssert(true, "Banner is Displayer")
//            let fullscreen = XCUIScreen.main.screenshot()
//            let screen = XCTAttachment(screenshot: fullscreen)
//            screen.lifetime = .keepAlways
//            add(screen)
//            banner.tap()
//        }
//        else {
//            XCTAssert(false, "Banner not Displayed")
//        }
        XCTAssert(app.buttons["OK"].waitForExistence(timeout: 10), "Browser Displayed")
        if app.buttons["OK"].exists{
            XCTAssert(true, "Click activate")
            let fullscreen = XCUIScreen.main.screenshot()
            let screen = XCTAttachment(screenshot: fullscreen)
            screen.lifetime = .keepAlways
            add(screen)
            app.buttons["OK"].tap()

        }
        else{
            XCTAssert(false, "Click do not activate")
        }
        
    }
    
    //MARK: Write the Show/Hide Buttons in Instream
    //MARK: Write the Custom text into Buttons Instream
    
    
    
    func testInstreamInPage() throws{
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app/*@START_MENU_TOKEN@*/.buttons["In Page"]/*[[".segmentedControls.buttons[\"In Page\"]",".buttons[\"In Page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Load Instream"].tap()
        sleep(5)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        
        let instream = app.webViews.element(boundBy: 2)
        XCTAssertTrue(instream.exists)
        XCTAssertTrue(instream.staticTexts["Learn More"].exists)
        XCTAssertEqual(instream.frame.size.width, 300)
        XCTAssertEqual(instream.frame.size.height, 250)
        
    }
    
    func testInstreamSkipButtonClick() throws{
        
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app/*@START_MENU_TOKEN@*/.buttons["In Page"]/*[[".segmentedControls.buttons[\"In Page\"]",".buttons[\"In Page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Load Instream"].tap()
        sleep(5)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        
        let instream = app.webViews.element(boundBy: 2)
        XCTAssertTrue(instream.exists)
        XCTAssertTrue(instream.staticTexts["Learn More"].exists)
        XCTAssertEqual(instream.frame.size.width, 300)
        XCTAssertEqual(instream.frame.size.height, 250)
        
        XCTAssertTrue(app.staticTexts["0:19"].waitForExistence(timeout: 10))
        app.staticTexts["Skip Ad"].tap()
        
        if !app.webViews.element(boundBy: 2).exists{
            print("Video In Page droped")
        }
        
        
    }
    
    func testInstreamLearnMooreClick() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app/*@START_MENU_TOKEN@*/.buttons["In Page"]/*[[".segmentedControls.buttons[\"In Page\"]",".buttons[\"In Page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Load Instream"].tap()
        sleep(5)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        
        let instream = app.webViews.element(boundBy: 2)
        XCTAssertTrue(instream.exists)
        XCTAssertTrue(instream.staticTexts["Learn More"].exists)
        XCTAssertEqual(instream.frame.size.width, 300)
        XCTAssertEqual(instream.frame.size.height, 250)
        
        XCTAssertTrue(app.staticTexts["0:19"].waitForExistence(timeout: 10))
        app.staticTexts["Learn More"].tap()
        
        sleep(5)
        
        if !app.webViews.element(boundBy: 2).exists{
            print("Video In Page droped")
        }
        
    }
    
    
    func testInstreamFullScreen() throws{
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app.buttons["Fullscreen"].tap()
        app.buttons["Load Instream"].tap()
        sleep(5)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        
        let instream = app.webViews.element(boundBy: 0)
        XCTAssertTrue(instream.exists)
        XCTAssertTrue(instream.staticTexts["Learn More"].exists)
        XCTAssertEqual(instream.frame.size.width, app.frame.size.width)
        XCTAssertEqual(instream.frame.size.height, app.frame.size.height)
        
    }
    // MARK: AdMob Test's Block
    func testBannerMediationAdmixerFirst() throws{
        
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("53b3fa56-209a-4d92-8ed1-5406d91c5d8b")
        app.buttons["Load Banner"].tap()
        sleep(5)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        let banner = app.webViews.element(boundBy: 0)
        XCTAssertTrue(banner.staticTexts["Test mode"].exists)
        XCTAssertTrue(banner.exists)
        XCTAssertTrue(app.buttons["Load Banner"].exists)
        XCTAssertEqual(banner.frame.size.width,300)
        XCTAssertEqual(banner.frame.size.height, 250)
        
    }
    func testInterstitialMediationAdmixerFirst() throws{

        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
      app.textFields["PlacementId"].typeText("d0f2c0d2-ea84-41e0-bf5d-f1b1990189ef")
        app.buttons["Load Interstitial"].tap()
        sleep(5)
        let frame = app.label.description
        print(frame)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        print(app.debugDescription)
        let banner = app.webViews.element(boundBy: 0)
        XCTAssertTrue(banner.staticTexts["Test mode"].exists)
        XCTAssertTrue(banner.exists)
        XCTAssertEqual(banner.frame.size.width,app.frame.size.width)
        XCTAssertEqual(banner.frame.size.height, app.frame.size.height)

    }
    
    func testRewardedAdMobMediationAdmixerFirts(){
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("9218feb0-4ea3-41e2-b101-d038bc783a3d")
        app.buttons["Load Rewarded"].tap()
        sleep(10)
        let rewarded = app.webViews.element(boundBy: 0)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        XCTAssertTrue(rewarded.staticTexts["Test mode"].exists)
        XCTAssertTrue(rewarded.exists)
        XCTAssertEqual(rewarded.frame.size.width, app.frame.size.width)
        XCTAssertEqual(rewarded.frame.size.height, app.frame.size.height)
    }
    // MARK: AdMob Test's Block End
    
    func testRewardedAdmixer() throws{
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app.buttons["Load Rewarded"].tap()
        sleep(2)
        let rewarded = app.webViews.element(boundBy: 0)
        let fullscreen = XCUIScreen.main.screenshot()
        let screen = XCTAttachment(screenshot: fullscreen)
        screen.lifetime = .keepAlways
        add(screen)
        XCTAssertTrue(rewarded.staticTexts["Learn More"].exists)
        XCTAssertTrue(rewarded.exists)
        XCTAssertEqual(rewarded.frame.size.width,414)
        XCTAssertEqual(rewarded.frame.size.height, 233)
    }
    
    func testRewardedAdmixerClose() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app.buttons["Load Rewarded"].tap()
        
        XCTAssertTrue(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10),"Rewarded not exist")
        if app.webViews.element(boundBy: 2).exists{
            print("Rewarded Exist")
        }
        sleep(15)
        if app.staticTexts.allElementsBoundByIndex.count == 2{
            app.buttons.element(boundBy: 0).tap()
        }
        sleep(1)
        if !app.webViews.element(boundBy: 2).exists{
            print("Rewarded Droped")
        }
    }
    
    
    func testRewardedClickOnCreative() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["PlacementId"].tap()
        app.textFields["PlacementId"].typeText("c744a785-272b-4b85-8a93-5eb581d74565")
        app.buttons["Load Rewarded"].tap()
        
        XCTAssertTrue(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10),"Rewarded not exist")
        if app.webViews.element(boundBy: 2).exists{
            print("Rewarded Exist")
        }
        sleep(2)
        if app.staticTexts["Learn More"].exists{
            app.staticTexts["Learn More"].tap()
        }
    }
    
    //MARK: Custom Instream Test's
    
    func testInstreamHideSkip() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        //print(app.debugDescription)
        app.buttons["Hide Skip"].tap()
        XCTAssertFalse(app.staticTexts["Skip Ad"].exists, "Skip not hide")
        sleep(2)
        
    }
    
    func testInstreamShowSkip() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.switches.element(boundBy: 0).tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        //print(app.debugDescription)
        if !app.staticTexts["Skip Ad"].exists{
            app.buttons["Show Skip"].tap()
            sleep(2)
        }
        else{
            XCTAssertTrue(false, "Skip Ad not hide in start")
        }
        XCTAssert(app.staticTexts["Skip Ad"].exists, "Skip Ad is not showing")
        
    }
    
    func testInstreamHideMute() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        if app.otherElements["30 seconds"].exists{
            app.buttons["Hide Mute"].tap()
            sleep(2)
        }
        else{
            XCTAssertTrue(false, "Mute not show in start")
        }
        XCTAssert(!app.otherElements.element(boundBy: 20).exists, "Mute is not hiding")
        
    }
    
    func testInstreamShowMute() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.switches.element(boundBy: 2).tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        //print(app.debugDescription)
        if !app.staticTexts["0:30"].exists{
            app.buttons["Show Mute"].tap()
            sleep(2)
        }
        else{
            XCTAssertTrue(false, "Mute not hide in start")
        }
        XCTAssert(app.otherElements["30 seconds"].exists, "Mute is not showing")
        
    }
    
    func testInstreamHideLearnMoore() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        //print(app.debugDescription)
        if app.staticTexts["Learn More"].exists{
            app.buttons["Hide Link"].tap()
        }
        XCTAssert(!app.staticTexts["Learn More"].exists, "Skip not hide")
        
    }
    
    func testInstreamShowLink() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        app.switches.element(boundBy: 1).tap()
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        //print(app.debugDescription)
        if !app.staticTexts["Learn More"].exists{
            app.buttons["Show Link"].tap()
            sleep(2)
        }
        else{
            XCTAssertTrue(false, "Skip Ad not hide in start")
        }
        XCTAssert(app.staticTexts["Learn More"].exists, "Skip Ad is not showing")
        
    }
    
    func testCustomLinkText() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        let link_text = app.textFields.element(boundBy: 0)
        link_text.tap()
        link_text.typeText("Link")
                
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        
        XCTAssert(app.staticTexts["Link"].exists, "Custom Link Text not set")
    
    }
    
    func testCustomSkipText() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["InStream"].tap()
        let skip_text = app.textFields.element(boundBy: 1)
        skip_text.tap()
        skip_text.typeText("Skip")
                
        app.buttons["Load Instream"].tap()
        XCTAssert(app.webViews.element(boundBy: 2).waitForExistence(timeout: 10))
        sleep(2)
        XCTAssert(app.staticTexts["Skip"].exists, "Custom Skip Text not set")
    
    }
    
    
}
