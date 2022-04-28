//
//  MentorProjectManagementRequests.swift
//  LearnByResearch
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 03/02/22.
//

import Foundation

struct MentorProjectManagementRequests {
//    static func createNewProjectRequestWith<T: Decodable>(requestModelData: Data?, resultType : T.Type, completionHandler:@escaping (_ result: T?, _ error: Error?) -> Void) {
//        if let urlIs =  URL(string: LBRApiConstants.mentorNewProjectApiPath), let _requestModelData = requestModelData {
//            LBRNetworkLayer().postApiData(requestUrl: urlIs, resultType: T.self, requestBody: _requestModelData) { (responseM, errIs) in
//                completionHandler(responseM, errIs)
//            }
//        }
//    }
    
    static func createNewProjectRequestWith<T: Decodable>(WithParameters parameters: [String: Any]?, WithImageModel imgM: ImageModel?, ForResultType resultType : T.Type, completionHandler:@escaping (_ result: T?, _ error: Error?) -> Void) {
        NetworkLayer().postMultipartApiData(WithUrlString: "http://3.108.215.127:3000/projectByMentor", WithParams: parameters, WithImageModelArr: [imgM], resultType: T.self) { (responseM, errIs) in
            completionHandler(responseM, errIs)
        }
    }
}
