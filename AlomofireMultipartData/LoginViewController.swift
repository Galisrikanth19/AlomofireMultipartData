//
//  LoginViewController.swift
//  AlomofireMultipartData
//
//  Created by Elorce on 28/04/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var welcomeVM = WelcomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allClosures()
        
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        welcomeVM.makeLoginRequest()
    }
    
}

// MARK: AllClosures
extension LoginViewController {
    
    private func allClosures() {
        welcomeVM.successfullyLoggedInCallBack = {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateProjectViewController") as? CreateProjectViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        welcomeVM.failedToLoggedInCallBack = {
            
        }
    }
    
}
