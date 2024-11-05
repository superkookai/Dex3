//
//  FetchedImage.swift
//  Dex3
//
//  Created by Weerawut Chaiyasomboon on 5/11/2567 BE.
//

import SwiftUI

//Because cannot use AsyncImage in Widget, so need to fetch from URL to UIImage
struct FetchedImage: View {
    let url: URL?
    
    var body: some View {
        if let url,
            let imageData = try? Data(contentsOf: url),
            let uiImage = UIImage(data: imageData){
            
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        }else{
            Image(.bulbasaur)
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}
