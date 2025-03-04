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

    @NSManaged public var content: UIImage?
    @NSManaged public var descr: String?
    @NSManaged public var id: String?

}

extension Photo : Identifiable {

}
