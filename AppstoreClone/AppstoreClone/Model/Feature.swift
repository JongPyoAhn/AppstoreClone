//
//  Feature.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/14.
//

import Foundation
struct Feature: Decodable{
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
