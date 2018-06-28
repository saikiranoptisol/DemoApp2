//
//  UserVc.swift
//  Demo
//
//  Created by Mac-OBS-07 on 28/06/18.
//  Copyright © 2018 Mac-OBS-07. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class UserVc: UIViewController {

    @IBOutlet weak var fNameLbl: UILabel!
    @IBOutlet weak var lNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    var userInfoVal = userInfo()
    var suscriptionInfo = [Data]()
    
    @IBOutlet weak var tableTv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getUserDetails()
        // Do any additional setup after loading the view.
    }

    func getUserDetails(){
        LoginManager.sharedInstance.getUserName() { responseValue in
            print(responseValue.firstname ?? "")
            self.userInfoVal = responseValue
            if responseValue.subscription?.data?.count != 0  {
                self.suscriptionInfo = (responseValue.subscription?.data)!
                self.fNameLbl.text = self.userInfoVal.firstname
                self.lNameLbl.text = self.userInfoVal.lastname
                self.emailLbl.text = self.userInfoVal.email
                self.genderLbl.text = self.userInfoVal.gender
            }
            self.tableTv.reloadData()
        }
    }
     override   func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UserVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suscriptionInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = suscriptionInfo[indexPath.row].subscriptionId
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view1.backgroundColor = UIColor.red
        let textLbl = UILabel()
        textLbl.frame = CGRect(x: 20, y: 5, width: view1.frame.width-40, height: 35)
        view1.addSubview(textLbl)
        textLbl.textColor = UIColor.white
        textLbl.text = "SubscriptionID's"
        return view1
    }
    
}
