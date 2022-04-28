//
//  LBRUserDefaults.swift
//  LearnByResearch
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 30/12/21.
//

import Foundation

struct LBRUserDefaults {
    
    static func saveRequiredData(ForKey key: String?, WithValue value: String?) {
        if let _key = key, let _value = value {
            UserDefaults.standard.setValue(_value, forKey: _key)
            UserDefaults.standard.synchronize()
        }
    }
    static func getRequiredData(Forkey key: String) -> String? {
        return UserDefaults.standard.object(forKey: key) as? String
    }
    
    static func clearDataFor(key: String!) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
