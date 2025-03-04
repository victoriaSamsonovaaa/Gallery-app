//
//  MyFavouritePhoto.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 4.03.25.
//

import Foundation
import SwiftData

@Model
class MyFavouritePhoto {
    @Attribute(.unique) var id: String
    var url: String
    var descriptionText: String?
    
    init(id: String, url: String, descriptionText: String?) {
        self.id = id
        self.url = url
        self.descriptionText = descriptionText
    }
}
