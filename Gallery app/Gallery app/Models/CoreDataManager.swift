//
//  CoreDataManager.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 5.03.25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FavouritesModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("unable to init CoreData \(error.localizedDescription)")
            }
        }
    }
    
    func addPhotoToFav(photo: SinglePhotoModel, image: UIImage) {
        print("started to add")
        let context = persistentContainer.viewContext
        let favoritePhoto = Photo(context: context)
        
        favoritePhoto.id = photo.id
        favoritePhoto.photoDescription = photo.description
        favoritePhoto.width = Int16(photo.width)
        favoritePhoto.height = Int16(photo.height)
        
        favoritePhoto.content = image.jpegData(compressionQuality: 0.9)
        saveContext(context: context)
        print("added")
    }
    
    func removeFromFav(photo: Photo) {
        let context = persistentContainer.viewContext
        context.delete(photo)
        saveContext(context: context)
        print("removed")
    }
    
    func fetchFavorites() -> [Photo] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        do {
            print("got all favourites")
            return try context.fetch(fetchRequest)
        } catch {
            print("failed to fetch favorites: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("saved successfully")
        } catch {
            print("failed to save context: \(error.localizedDescription)")
        }
    }

    func fetchImageData(for photoID: String) -> Data? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", photoID)
        do {
            if let photo = try context.fetch(fetchRequest).first {
                return photo.content
            }
        } catch {
            print("failed to fetch image data: \(error.localizedDescription)")
        }
        return nil
    }
    
    private func isPhotoInFavorites(photoID: String) -> Photo? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", photoID)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("failed to check favorite status: \(error.localizedDescription)")
            return nil
        }
    }
    
    func toggleFavorite(photo: SinglePhotoModel, image: UIImage) {
        let context = persistentContainer.viewContext
        if let existingPhoto = isPhotoInFavorites(photoID: photo.id) {
            context.delete(existingPhoto)
            print("removed from favorites")
        } else {
            let favoritePhoto = Photo(context: context)
            favoritePhoto.id = photo.id
            favoritePhoto.photoDescription = photo.description
            favoritePhoto.width = Int16(photo.width)
            favoritePhoto.height = Int16(photo.height)
            favoritePhoto.content = image.jpegData(compressionQuality: 0.9)
            print("added to favorites")
        }
        saveContext(context: context)
    }

}
