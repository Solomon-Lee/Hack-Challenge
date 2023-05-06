//
//  AdoptionPet.swift
//  Housing and Pet
//
//  Created by Eman Abdu on 5/5/23.
//

import Foundation
import UIKit

struct AdoptionPet {
    var id : Int?
    var pet_owner_id : Int?
    var pet_adopter_id : Int?
    var name: String?
    var age: String
    var gender : String?
    var category : String?
    var breed : String?
    var on_campus : Bool
    var off_campus : Bool
    var outside : Bool
//    var start_time : String?
    var end_time : String?
    var pet_description : String?
    var additional_info : String?
    var food_supplies : Bool
    var adopter_reward : Bool
    var assets : [asset]?
}

struct asset {
    var base_url : String?
    var created_at : String?
    var asset_id : Int?
    var user_id : Int?
    var pet_sitting_id : Int?
    var pet_adoption_id : Int?
}

struct AdoptionPets {
    var pet_adoption_requests : [AdoptionPet]
}
