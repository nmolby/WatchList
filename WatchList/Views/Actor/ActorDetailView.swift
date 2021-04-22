//
//  ActorDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 3/30/21.
//

import Foundation
import SwiftUI
import Combine

struct ActorDetailView: View {
    internal let actor: Cast
    @State internal var person: Person?
    @Environment(\.managedObjectContext) private var viewContext

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        Group {
            if let person = person {
                PersonDetailView(actor: Actor.createFromPerson(person: person, context: viewContext))
            } else {
                Spacer()
            }
        }
        .onAppear() {
            getPerson()
        }
    }
    
    func getPerson()  {
        api.person(id: actor.id).sink { (_) in

        } receiveValue: { person in
            self.person = person
        }.store(in: &cancellables)
    }
}
