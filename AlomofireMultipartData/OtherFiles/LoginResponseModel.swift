//
//  LoginResponseModel.swift
//  LearnByResearch
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 30/12/21.
//

import Foundation

struct LoginResponseModel: Codable {
    let status: Bool?
    let token: Token?
    let userDetails: UserDetails?
    let message: String?
}

struct Token: Codable {
    let accessToken, refreshToken: String?
}

struct UserDetails: Codable {
    let basic_sign_id: Int?
    let master_user_type_id: Int?
}
