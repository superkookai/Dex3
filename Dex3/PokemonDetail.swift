//
//  PokemonDetail.swift
//  Dex3
//
//  Created by Weerawut Chaiyasomboon on 4/11/2567 BE.
//

import SwiftUI
import CoreData

struct PokemonDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var pokemon: Pokemon
    @State private var showShiny = false
    
    var body: some View {
        ScrollView{
            ZStack{
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                
                AsyncImage(url: showShiny ? pokemon.shiny : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.top,50)
                        .shadow(color: .black, radius: 6)
                }placeholder: {
                    ProgressView()
                }
            }
            
            HStack{
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .shadow(color: .white, radius: 1)
                        .padding([.top,.bottom],7)
                        .padding([.leading, .trailing])
                        .background(Color(type.capitalized))
                        .clipShape(.capsule)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        pokemon.favorite.toggle()
                        //Save to CoreData
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                } label: {
                    if pokemon.favorite {
                        Image(systemName: "star.fill")
                    }else{
                        Image(systemName: "star")
                    }
                }
                .font(.largeTitle)
                .foregroundStyle(.yellow)

            }
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom,-7)
            
            StatsView()
                .environmentObject(pokemon)
        }
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    Image(systemName: showShiny ? "wand.and.stars" : "wand.and.stars.inverse")
                        .foregroundStyle(showShiny ? .yellow : .primary)
                }

            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetail()
            .environmentObject(SamplePokemon.samplePokemon)
    }
}
