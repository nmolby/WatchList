//
//  ContentView.swift
//  WatchList
//
//  Created by David M Reed on 2/13/21.
//

import SwiftUI
import Combine
import CoreData

extension MovieSearch.Result: Identifiable { }
extension TVSearch.Result: Identifiable { }
extension Cast: Identifiable {}
extension PersonCredits.Cast: Identifiable {}

extension PersonCredits.Cast {
    var displayInfo: String {
        if mediaType == .movie {
            if let title = originalTitle {
                if let name = name {
                    return "\(title) : \(name)"
                } else {
                    return title
                }
            }
            return ""
        } else if mediaType == .tv {
            if let name = name {
                if let ch = character {
                    return "\(name) : \(ch)"
                } else {
                    return name
                }
            }
            return ""
        }
        return ""
    }
}

struct MovieCreditsView: View {
    let movieID: Int
    let navTitle: String
    @State private var cast: [Cast] = []

    var body: some View {
        List {
            ForEach(cast) { p in
                NavigationLink(p.name, destination: PersonCreditsView(personID: p.id, navTitle: p.name))
            }
        }
        .navigationTitle(navTitle)
        .onAppear {
            api.movieCredits(id: movieID).sink { (completion) in

            } receiveValue: { (movieCredits) in
                cast = movieCredits.cast
            }.store(in: &cancellables)
        }
    }

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

struct TVSearchView: View {

    @State private var searchText = ""
    @State private var totalResults = 0
    @State private var results: [TVSearch.Result] = []

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("TV name", text: $searchText,
                        onEditingChanged: { changing in
                        if !changing {
                            search(searchText)
                        }
                    })
                    Button("Search") {
                        search(searchText)
                    }
                }
                .padding()
                ContentListView<[TVSearch.Result]>(results: $results)
            }
            .navigationBarTitle("TV", displayMode: .inline)
        }
    }

    func search(_ s: String) {
        results = []
        api.tvSearch(match: s).sink { (completion) in

        } receiveValue: { (search) in
            totalResults = search.totalResults
            results = search.results.sorted { lhs, rhs in
                lhs.name < rhs.name
            }
        }.store(in: &cancellables)
    }

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

struct TVCreditsView: View {
    let tvID: Int
    let navTitle: String
    @State private var cast: [Cast] = []

    var body: some View {
        List {
            ForEach(cast) { p in
                NavigationLink(p.name, destination: PersonCreditsView(personID: p.id, navTitle: p.name))
            }
        }
        .navigationTitle(navTitle)
        .onAppear {
            api.tvCredits(id: tvID).sink { (completion) in

            } receiveValue: { (tvCredits) in
                cast = tvCredits.cast
            }.store(in: &cancellables)
        }
    }

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}


struct PersonCreditsView: View {
    let personID: Int
    let navTitle: String
    @State private var cast: [PersonCredits.Cast] = []

    var body: some View {
        List {
            ForEach(cast) { c in
                if c.mediaType == .movie {
                    NavigationLink(c.displayInfo, destination: MovieCreditsView(movieID: c.id, navTitle: c.displayInfo))
                } else if c.mediaType == .tv {
                    NavigationLink(c.displayInfo, destination: TVCreditsView(tvID: c.id, navTitle: c.displayInfo))
                } else {
                    Text(c.displayInfo)
                }
            }
        }
        .navigationTitle(navTitle)
        .onAppear {
            api.personCredits(id: personID).sink { (completion) in

            } receiveValue: { (personCredits) in
                cast = personCredits.cast
            }.store(in: &cancellables)
        }
    }

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}


struct ContentView: View {

    var body: some View {
        TabView {
            MovieSearchView()
                .tabItem { Text("Movies") }
            TVSearchView()
                .tabItem { Text("TV") }
        }
    }
}

//struct ContentView: View {
//    @State private var cancellables: Set<AnyCancellable> = []
//
//    var body: some View {
//        Text("hello")
//            .onAppear {
//                let api = MovieDBAPI(apiKey: APIKey.apiKey)
//
//                api.tvSearch(match: "Imposter").sink { (completion) in
//                    print(completion)
//                } receiveValue: { (tvSearch) in
//                    print(tvSearch.results)
//
//                    let results = tvSearch.results
//                    if results.count > 0 {
//
//                        api.tv(id: results[0].id).sink { (completion) in
//                            print(completion)
//                        } receiveValue: { (tv) in
//                            print(tv)
//                        }.store(in: &cancellables)
//
//
//                        api.tvCredits(id: results[0].id).sink { (completion) in
//                            print(completion)
//                        } receiveValue: { (credits) in
//                            for c in credits.cast {
//                                if let character = c.character {
//                                    print("\(c.name) : \(character)")
//                                } else {
//                                    print(c.name)
//                                }
//                            }
//                        }.store(in: &cancellables)
//                    }
//                }.store(in: &cancellables)
//
//
//                api.personSearch(match: "Inbar Lavi").sink { (completion) in
////                api.personSearch(match: "Bryan Cranston").sink { (completion) in
//                    print("completion", completion)
//
//                } receiveValue: { (personSearch) in
//                    let id = personSearch.results[0].id
//
//                    api.personCredits(id: id).sink { (completion) in
//                        print("completion", completion)
//                    } receiveValue: { (personCredits) in
//                        for c in personCredits.cast {
//                            if c.mediaType == .movie, let title = c.originalTitle {
//                                print("movie", title, terminator:": ")
//                            } else if c.mediaType == .tv, let name = c.name {
//                                print("tv", name, terminator: ": ")
//                            }
//                            if let character = c.character {
//                                print(character)
//                            } else {
//                                print()
//                            }
//
//                        }
//                    }.store(in: &cancellables)
//                }.store(in: &cancellables)
//            }
//    }
//}

//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
