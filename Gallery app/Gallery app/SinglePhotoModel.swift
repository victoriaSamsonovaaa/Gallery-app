//
//  SinglePhotoModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation

struct SinglePhotoModel: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case thumb
        case small
    }
}
