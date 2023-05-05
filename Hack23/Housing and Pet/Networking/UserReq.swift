//
//  UserReq.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/4/23.
//

import Foundation


struct userResponse: Codable{
    var session_token: String
    var update_token: String
    var session_expiration: String
}

struct loginUser: Codable{
    var email: String
    var password: String
}

struct logoutMessage: Codable{
    var message: String
}

struct AppUser: Codable{
    var id: Int
    var email: String
    var username: String
    var phone: String?
    var gender: String?
    var age: String?
    var college_student: Bool?
    var curr_location: String?
    var pet_owner_boolean: Bool?
    var session_token: String
    var update_token:String
    var session_expiration:String
    var pet_owner_sitting_requests: [petSittingReq]
    var pet_sitter_requests: [petSittingReq]
    var pet_owner_adoption_requests: [petAdopReq]
    var pet_adopter_requests: [petAdopReq]
    var sent_messages: [messagee]
    var received_messages: [messagee]
    var asset: assett?
}

struct petSittingReq: Codable{
    var id: Int
    var pet_owner_id: Int
    var pet_sitter_id: Int?
    var name: String
    var age: String
    var gender: String
    var category: String
    var breed: String
    var on_campus: Bool
    var off_campus: Bool
    var outside: Bool
    var start_time: String
    var end_time: String
    var pet_description: String
    var additional_info: String
    var food_supplies: Bool
    var sitter_pay: Bool
    var sitter_housing: Bool
    var assets: [assett]
    
}

struct assett: Codable{
    var base_url: String
    var created_at: String
    var asset_id: Int
    var user_id: Int?
    var pet_sitting_id: Int?
    var pet_adoption_id: Int?
}

struct petAdopReq: Codable{
    var id: Int
    var pet_owner_id: Int
    var pet_adopter_id: Int?
    var name: String
    var age: String
    var gender: String
    var category: String
    var breed: String
    var on_campus: Bool
    var off_campus: Bool
    var outside: Bool
    var end_time: String
    var pet_description: String
    var additional_info: String
    var food_supplies: Bool
    var adopter_reward: Bool
    var assets: [assett]
}

struct messagee:Codable{
    var id: Int
    var sender_id: Int
    var recipient_id: Int
    var content: String
    var timestamp: String
}




