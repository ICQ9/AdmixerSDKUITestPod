//
//  AMGDPRDescription.swift
//  AdmixerSDK
//
//  Created by Ivan Ganzha on 23.09.2021.
//  Copyright © 2021 Admixer. All rights reserved.
//

import Foundation
struct AMGDPRDescription: Codable {
    var consentRequired: Bool?
    var consentString: String?
    
    enum CodingKeys: String, CodingKey {
        case consentRequired = "consent_required"
        case consentString = "consent_string"
    }
    
    init(consentRequired: Bool, consentString: String) {
        self.consentRequired = consentRequired
        self.consentString = consentString
    }
    
}
