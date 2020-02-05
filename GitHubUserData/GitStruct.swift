//
//  GitStruct.swift
//  GitHubUserData
//
//  Created by apple on 05/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
struct GitUser:Codable {
    let login:String?
    let id:Int?
    let avatar_url:URL?
    let followers_url:String?
    let bio:String?
    let public_repos:Int?
    let location:String?
    let type:String?
    let created_at:String?
    let updated_at:String?
    let node_id:String?
    
    private enum CodingKeys : String,CodingKey {
        case login
        case id
        case avatar_url="avatar_url"
        case followers_url="followers_url"
        case bio
        case public_repos
        case location
        case type
        case created_at
        case updated_at
        case node_id
        
        
        
    }
}
