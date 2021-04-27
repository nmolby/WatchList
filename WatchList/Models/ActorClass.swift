//
//  ActorClass.swift
//  WatchList
//
//  Created by Nathan Molby on 4/27/21.
//

import CoreData
import Foundation

class ActorClass: ObservableObject {
    @Published internal var actor: Actor?
    @Published internal var biography: String?
    @Published internal var birthday: String?
    @Published internal var department: String?
    @Published internal var homepage: String?
    @Published internal var name: String?
    @Published internal var profilePath: String?
    @Published internal var id: Int16
    @Published internal var gender: Int16


    init(person: Person) {
        biography = person.biography
        birthday = person.birthday
        department = person.knownForDepartment
        gender = Int16(person.gender)
        homepage = person.homepage
        id = Int16(person.id)
        name = person.name
        profilePath = person.profilePath
    }
    
    init(actor: Actor) {
        self.actor = actor
        biography = actor.biography
        birthday = actor.birthday
        department = actor.department
        gender = Int16(actor.gender)
        homepage = actor.homepage
        id = Int16(actor.id)
        name = actor.name
        profilePath = actor.profilePath
    }
    
    func addToViewContext(context: NSManagedObjectContext) {
        let actor = Actor(context: context)
        actor.biography = biography
        actor.birthday = birthday
        actor.department = department
        actor.gender = gender
        actor.homepage = homepage
        actor.id = id
        actor.name = name
        actor.profilePath = profilePath
        
        self.actor = actor
        do {
            try context.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
    
    func removeFromViewContext(context: NSManagedObjectContext) {
        if let actor = actor {
            context.delete(actor)
            do {
                try context.save()
            } catch {
                print("save failed, error \(error)")
            }
            self.actor = nil
        }

    }
}
