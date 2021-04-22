//
//  Actor.swift
//  WatchList
//
//  Created by Nathan Molby on 4/22/21.
//

import Foundation
import CoreData

extension Actor {
    static func createFromPerson(person: Person, context: NSManagedObjectContext) -> Actor {
        let actor = Actor(context: context)
        actor.biography = person.biography
        actor.birthday = person.birthday
        actor.department = person.knownForDepartment
        actor.gender = Int16(person.gender)
        actor.homepage = person.homepage
        actor.id = Int16(person.id)
        actor.name = person.name
        actor.profilePath = person.profilePath
        return actor
    }
}
