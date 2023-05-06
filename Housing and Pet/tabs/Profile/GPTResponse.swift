//
//  GPTResponse.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/5/23.
//

import Foundation

struct GPTResponse: Codable{
    let choices: [GPTcompletion]
}

struct GPTcompletion: Codable{
    let text: String
    let finishReason: String
}
