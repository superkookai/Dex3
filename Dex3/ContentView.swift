//
//  ContentView.swift
//  Dex3
//
//  Created by Weerawut Chaiyasomboon on 3/11/2567 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default
    ) private var pokedex: FetchedResults<Pokemon>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        predicate: NSPredicate(format: "favorite = %d", true),
        animation: .default
    ) private var favorites: FetchedResults<Pokemon>
    
    @State private var filterByFavorites = false
    @StateObject private var pokemonVM = PokemonViewModel(controller: FetchController())
    
    var body: some View {
        switch pokemonVM.status {
        case .notstarted:
            EmptyView()
        
        case .fetching:
            ProgressView()
            
        case .success:
            NavigationStack {
                List(filterByFavorites ? favorites : pokedex) { pokemon in
                    NavigationLink(value: pokemon) {
                        //Inside like HStack
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        
                        Text("\(pokemon.name!.capitalized)")
                        
                        if pokemon.favorite {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
                .navigationTitle("Pokedex")
                .navigationDestination(for: Pokemon.self, destination: { pokemon in
                    PokemonDetail()
                        .environmentObject(pokemon)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation{
                                filterByFavorites.toggle()
                            }
                        } label: {
                            Label("Filter by Favorites", systemImage: filterByFavorites ? "star.fill" : "star")
                        }
                        .tint(.yellow)
                    }
                }
            }
        case .failed(error: let error):
            Text(error.localizedDescription)
        }
    }
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
