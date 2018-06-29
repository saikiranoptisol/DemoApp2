//
//  ForgotPassword.swift
//  Demo
//
//  Created by Mac-OBS-07 on 29/06/18.
//  Copyright © 2018 Mac-OBS-07. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ForgotPassword: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidEmail(emailStr: String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }

    @IBAction func submitBtnTap(_ sender: Any) {
    
        if (emailField.text?.isEmpty)! {
            print("Field cant be empty")
        }
        else if !isValidEmail(emailStr: emailField.text!) {
            print("invalidEmail")
        }
        else{
            
            let parameters: Parameters = [
                Constant().PEmail: emailField.text!
            ]
            LoginManager.sharedInstance.forgotPasswordValue(param: parameters, completion: {responseValue in
                
                print(parameters)
                
                if let successMessage = responseValue.data?.response {
                    print(successMessage)
                    }
            })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

}
