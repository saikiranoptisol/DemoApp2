//
//  ForgotPasswordInfo.swift
//  Demo
//
//  Created by Mac-OBS-07 on 28/06/18.
//  Copyright © 2018 Mac-OBS-07. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgotPasswordInfo: Mappable {
    var status: String?
    var data: data?
    required convenience init?(map: Map) {
        self.init()
    }
    
     func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
    }
}

class data: Mappable {
    
    var accepted: [String]?
    var rejected: [String]?
    var response: String?
    var envelope: envelope?
    var messageId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        accepted <- map["accepted"]
        rejected <- map["rejected"]
        response <- map["response"]
        envelope <- map["envelope"]
        messageId <- map["messageId"]
    }
}

class envelope: Mappable {
    var from: String?
    var to: [String]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        from <- map["from"]
        to <- map["to"]
    }
}
