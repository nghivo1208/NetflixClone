//
//  DataPersistanceManager.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 12/04/2023.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager {
    
    enum DatabaseError: Error{
        case failToSaveData
        case failToFetchData
        case failToDeleteData
    }
    
    static let share = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(())) // if return a void can't use Void cause of Void is a DataType not a value, just                           //return something empty like ()
        }catch{
            completion(.failure(DatabaseError.failToSaveData))
        }
    }
    
    func fetchingTitleFromDataBase(completion: @escaping (Result<[TitleItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let request:NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do{
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
        }catch{
            completion(.failure(DatabaseError.failToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)   //asking the database manager to delete certain object
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failToDeleteData))
        }
    
    }
    
    
}
