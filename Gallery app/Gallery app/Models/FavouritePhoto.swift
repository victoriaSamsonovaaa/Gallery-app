//
//  Photo+CoreDataProperties.swift
//
//
//  Created by Victoria Samsonova on 5.03.25.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(Photo)
class Photo: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var content: Data?
    @NSManaged public var height: Int16
    @NSManaged public var id: String?
    @NSManaged public var photoDescription: String?
    @NSManaged public var width: Int16

}

extension Photo : Identifiable {

}
