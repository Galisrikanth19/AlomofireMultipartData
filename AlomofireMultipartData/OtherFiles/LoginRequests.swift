//
//  LoginRequests.swift
//  LearnByResearch
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 02/12/21.
//

import Foundation

struct LoginRequests {
    
    static func makeLoginRequestWith<T: Decodable>(requestModelData: Data?, resultType : T.Type, completionHandler:@escaping (_ result: T?, _ error: Error?) -> Void) {
        if let urlIs =  URL(string: "http://3.108.215.127:3000/login"), let _requestModelData = requestModelData {
            NetworkLayer().postApiData(requestUrl: urlIs, resultType: T.self, requestBody: _requestModelData) { (responseM, errIs) in
                completionHandler(responseM, errIs)
            }
        }
    }
    
}
