//
//  Constants.swift
//  AlomofireMultipartData
//
//  Created by Elorce on 20/01/22.
//

import Foundation

struct Constants {

    static let basicSignIdKey = "basicSignId"
    static let masterUserTypeIdKey = "masterUserTypeId"
    static let accessTokenKey = "accessToken"
    static let refreshTokenKey = "refreshToken"
    
    
    static func getBasicSignId() -> String? {
        return UserDefaults.standard.object(forKey: Constants.basicSignIdKey) as? String
    }
    
    static func getMasterUserTypeId() -> String? {
        return UserDefaults.standard.object(forKey: Constants.masterUserTypeIdKey) as? String
    }
    
    static func getAccessToken() -> String? {
        return UserDefaults.standard.object(forKey: Constants.accessTokenKey) as? String
    }
    
    static func getRefereshToken() -> String? {
        return UserDefaults.standard.object(forKey: Constants.refreshTokenKey) as? String
    }
    
}
