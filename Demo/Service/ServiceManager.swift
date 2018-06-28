//
//  ServiceManager.swift
//  Skynet
//
//  Created by Mac-OBS-8 on 13/04/18.
//  Copyright © 2018 Mac-OBS-8. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import NVActivityIndicatorView

enum ResponseCode: Int {
    
    // Requested api returns expected response
    case sucess                 = 200
    
    // Email Id not found
    case inVaildEmail           = 201
    
    // Invaild OTP
    case inValidOTP             = 202
    
    // Password Mismatching
    case inValidPwd             = 203
    
    // Token Mismatching
    case tokenMismatch          = 204
    
    // File not found
    case FileUnvailable         = 206
    
    // SR ID not found
    case srIdUnvailable         = 207
    
    // ISR ID not found
    case isrIdUnvailable        = 208
    
    // File name not found
    case fileNameUnvailable     = 209
    
    // Some thing went wrong
    case unExpectedError        = 210
    
    // Invalid password
    case pwdInvalid             = 211
    
    // Previous password already exists
    case previousPwdSame        = 212
    
    // User display or read permission missing
    case permissionDisAllow     = 230
    
    // The HTTP request is incomplete or malformed.
    case badRequest             = 400
    
    // Authorization is required to use the service
    case unAuthorization        = 401
    
    // User do not have permission to access the database.
    case forbidden              = 403
    
    // The named database is not running on the server, or the named web service does not exist.
    case notFound               = 404
    
    // The maximum connection idle time was exceeded while receiving the request
    case timeOut                = 408
    
    // An internal error occurred. The request could not be processed.
    case serviceUnavailable     = 500
    
    // No internet
    case noNetwork              = -1
}

class ServiceManager: UIViewController, NVActivityIndicatorViewable {
    
    class var sharedInstance: ServiceManager {
        struct Static {
            static let instance = ServiceManager()
        }
        return Static.instance
    }
    
    //MARK: - LocalVariable
    var sessionManager: Alamofire.SessionManager?
    var activityIndicatorView: NVActivityIndicatorView?
    
    /**
     Call Webservice with single model
     
     - Parameter type:                   Mappable model for this API Call
     - parameter endPointURL:            EndPoint URL for this API. Default: empty string.
     - parameter Params:                 Parameters for this API. Default: nil
     - parameter headers:                headers for this Api.  Default: nil
     - Completion:                       Return model response to the handler
     */
    
    func requestToApi<T: Mappable>(type: T.Type,
                                   with endPointURL: String,
                                   urlMethod: HTTPMethod!,
                                   params: Parameters? = nil,
                                   headers:HTTPHeaders? = nil,
                                   encode: ParameterEncoding? = JSONEncoding.default,                                   completion: @escaping(_ result: DataResponse<T>?, _ statusCode: ResponseCode) -> Void) {
        
        // start animation
        let animating = NVActivityIndicatorPresenter.sharedInstance.isAnimating
        if animating == isAnimating {
            let size = CGSize(width: 30, height: 30)
            startAnimating(size, message: "Loading...", type: .lineSpinFadeLoader)
        }

        let url = URLConstant().KBaseURL + endPointURL
        
        print("Request URL: \(url)")
        print("Parameters: \(String(describing: params))")

        Alamofire.request(url, method: urlMethod!, parameters: params, encoding:encode!,headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            
            // response serialization result
            print("Result: \(response.result)")

            // stop Animation
            self.stopAnimating()
            
            if let alamoError = response.result.error {
                if let err = alamoError as? URLError {
                    print(err)
                   // self.errorCode(errorCode: err)
                }
                else if response.response?.statusCode == nil{
                    completion(response, self.statusCodeForResponseCode(alamoError._code))
                }
                else {
                    completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
                }
            }
            else {
                completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
            }
        }
    }
    
  /*  func requestToApiForLocationUpdate<T: Mappable>(type: T.Type,
                                                    with endPointURL: String,
                                                    urlMethod: HTTPMethod!,
                                                    showLoader: Bool,
                                                    params: Parameters? = nil,
                                                    headers:HTTPHeaders? = nil,
                                                    encode: ParameterEncoding? = JSONEncoding.default,                                   completion: @escaping(_ result: DataResponse<T>?, _ statusCode: ResponseCode) -> Void) {
        if showLoader {
            // start animation
            let animating = NVActivityIndicatorPresenter.sharedInstance.isAnimating
            if animating == isAnimating {
                let size = CGSize(width: 30, height: 30)
                startAnimating(size, message: "Loading...", type: .lineSpinFadeLoader)
            }
        }
        
        let url = URLConstant().KBaseURL + endPointURL
        print("Request URL: \(url)")
        print("Parameters: \(String(describing: params))")
        
        Alamofire.request(url, method: urlMethod!, parameters: params, encoding:encode!,headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            // response serialization result
            print("Result: \(response.result)")
            
            // stop Animation
            self.stopAnimating()
            
            if let alamoError = response.result.error {
                if let err = alamoError as? URLError {
                    print(err)
                  //  self.errorCode(errorCode: err)
                }
                else if response.response?.statusCode == nil{
                    completion(response, self.statusCodeForResponseCode(alamoError._code))
                }
                else {
                    completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
                }
            }
            else {
                completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
            }
        }
    } */
    
    
    
    //MARK: - STATUS CODE
    func statusCodeForResponseCode(_ statusCode:Int) -> ResponseCode {
        switch statusCode {
        case 200:
            return .sucess
        case 201:
            return .inVaildEmail
        case 202:
            return .inValidOTP
        case 203:
            return .inValidPwd
        case 204:
            return .tokenMismatch
        case 206:
            return .FileUnvailable
        case 207:
            return .srIdUnvailable
        case 208:
            return .isrIdUnvailable
        case 209:
            return .fileNameUnvailable
        case 210:
            return .unExpectedError
        case 211:
            return .pwdInvalid
        case 212:
            return .previousPwdSame
        case 230:
            return .permissionDisAllow
        case 400:
            return .badRequest
        case 401:
            return .unAuthorization
        case 403:
            return .forbidden
        case 404:
            return .badRequest
        case 408:
            return .timeOut
        case 500:
            return .serviceUnavailable
        default:
            return .timeOut
        }
    }
    
  /*  func errorCode(errorCode: URLError) {
        switch errorCode.code {
        case .notConnectedToInternet:
            if let topController = AppUtils.sharedInstance.topViewController() {
                OBSAlert.sharedInstance.simpleAlert(view: topController, title: Constant().SEmpty, message: Constant().MNoInterNetConnection)
            }
            break
        case .timedOut:
            if let topController = AppUtils.sharedInstance.topViewController() {
                OBSAlert.sharedInstance.simpleAlert(view: topController, title: Constant().SEmpty, message: Constant().MRequestTimeOut)
            }
            break
        case .networkConnectionLost:
            if let topController = AppUtils.sharedInstance.topViewController() {
                OBSAlert.sharedInstance.simpleAlert(view: topController, title: Constant().SEmpty, message: Constant().MRequestTimeOut)
            }
            break
        default:
            break
        }
    } */
}



