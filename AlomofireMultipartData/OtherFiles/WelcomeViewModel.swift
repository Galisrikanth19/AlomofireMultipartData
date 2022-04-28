//
//  WelcomeViewModel.swift
//  LearnByResearch
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 30/12/21.
//

import Foundation

class WelcomeViewModel {
    var successfullyLoggedInCallBack:(() -> ())?
    var failedToLoggedInCallBack:(() -> ())?
    
    func makeLoginRequest() {
        if let loginRequestModelData = buildRequestModelData() {
            LoginRequests.makeLoginRequestWith(requestModelData: loginRequestModelData, resultType: LoginResponseModel.self) { (responseM, errIs) in
                if let _ = errIs {
                    //self.failedToLoggedInCallBack?()
                } else if let _responseM = responseM {
                    if let status = _responseM.status, status == true {
                        self.saveLoginData(ForModel: _responseM)
                    } else if let status = _responseM.status, status == false {
                      //  self.failedToLoggedInCallBack?()
                    }
                }
            }
        }
    }
    
    private func buildRequestModelData() -> Data? {
        let loginRequestM = LoginRequestModel(email: "madhubabu@gmail.com", password: "Elorce@123")
        let dataObj: Data? = try? JSONEncoder().encode(loginRequestM)
        return dataObj
    }
    
    private func saveLoginData(ForModel loginResponseM: LoginResponseModel) {
        if let _basicSignId = loginResponseM.userDetails?.basic_sign_id,
           let _masterUserTypeId = loginResponseM.userDetails?.master_user_type_id,
           let _accessToken = loginResponseM.token?.accessToken,
           let _refreshToken = loginResponseM.token?.refreshToken {
            LBRUserDefaults.saveRequiredData(ForKey: Constants.basicSignIdKey, WithValue: "\(_basicSignId)")
            LBRUserDefaults.saveRequiredData(ForKey: Constants.masterUserTypeIdKey, WithValue: "\(_masterUserTypeId)")
            
            LBRUserDefaults.saveRequiredData(ForKey: Constants.accessTokenKey, WithValue: _accessToken)
            LBRUserDefaults.saveRequiredData(ForKey: Constants.refreshTokenKey, WithValue: _refreshToken)
            
            
            self.successfullyLoggedInCallBack?()
        } else {
            self.failedToLoggedInCallBack?()
        }
    }
    
}
