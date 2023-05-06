//
//  DallE.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/5/23.
//

import Foundation

struct DallEResponse: Decodable {
    let data: [ImageURL]
}

struct ImageURL: Decodable {
    let url: String
}
