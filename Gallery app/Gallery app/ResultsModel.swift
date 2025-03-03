//
//  ResultsModel.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 3.03.25.
//

import Foundation

struct ResultsModel: Decodable {
    let total: Int
    let results: [SinglePhotoModel]
}
