//
//  Cat.swift
//  hackaton
//
//  Created by Eman Abdu on 4/30/23.
//

import Foundation
import UIKit

struct Pet {
    var id : Int?
    var pet_owner_id : Int?
    var pet_sitter_id : Int?
    var name: String?
    var age: String
    var gender : String?
    var category : String?
    var breed : String?
    var on_campus : Bool
    var off_campus : Bool
    var outside : Bool
    var start_time : String?
    var end_time : String?
    var pet_description : String?
    var additional_info : String?
    var food_supplies : Bool
    var sitter_pay : Bool
    var sitter_housing : Bool
    var assets : [assets]?
}

struct assets {
    var base_url : String?
    var created_at : String?
    var asset_id : Int?
    var user_id : Int?
    var pet_sitting_id : Int?
    var pet_adoption_id : Int?
}

struct Pets {
    var pet_sitting_requests : [Pet]
}
