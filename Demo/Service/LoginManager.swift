//
//  LoginManager.swift
//  Demo
//
//  Created by Mac-OBS-07 on 28/06/18.
//  Copyright © 2018 Mac-OBS-07. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import NVActivityIndicatorView

class LoginManager: NSObject {

    class var sharedInstance : LoginManager{
        struct Static  {
            
            static let instance = LoginManager()
        }
    return Static.instance
    }

    func getUserName(completion: @escaping (_ statusCode : userInfo ) -> Void) -> Void{
        
       // let accessToken = "aELFNtfS4BDaFS7e5rlqCYFLEU6xfn0vFniInGQdYM1bAQ0CHuDqoAYVT9WD1RBTAgyRykD4lxIVTjTA77A4XefZjmcMvAq6Uwp39wwWIJgjaoatmON1QtQ6Nk8s45Hc5210fjL5XtPAzPANu5BWZ2LAd6wEmosdcceO6CJwoKwyuruVO7DdwN4C7vnVHkFc1KguXYVPPO9DSwADkEqnwWvV7vhc10CNy4ADApItn78Y40J0eMRLrqu1LQJg6E72"
        let requestMethod: HTTPMethod = .get
        let headers = [Constant().SContentType: Constant().SApplicationJson, Constant().SAuthorization:"bearer aELFNtfS4BDaFS7e5rlqCYFLEU6xfn0vFniInGQdYM1bAQ0CHuDqoAYVT9WD1RBTAgyRykD4lxIVTjTA77A4XefZjmcMvAq6Uwp39wwWIJgjaoatmON1QtQ6Nk8s45Hc5210fjL5XtPAzPANu5BWZ2LAd6wEmosdcceO6CJwoKwyuruVO7DdwN4C7vnVHkFc1KguXYVPPO9DSwADkEqnwWvV7vhc10CNy4ADApItn78Y40J0eMRLrqu1LQJg6E72"]
        
        ServiceManager.sharedInstance.requestToApi(type: userInfo.self, with: URLConstant().KUser, urlMethod: requestMethod, params: nil, headers: headers,encode: URLEncoding.default, completion: { response, responseCode in
            
            if (response?.result.isSuccess)! {
                if let responseValue = response?.value {
                    print("Success: \(response!)")
                    completion(responseValue)
                }
            }
            else {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Failure: \(utf8Text)")
                   // AppUtils.sharedInstance.failurResponse(message: utf8Text)
                }
            }
        })
    }
}
