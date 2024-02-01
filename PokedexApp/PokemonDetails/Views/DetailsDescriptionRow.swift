//
//  DetailsDescriptionRow.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import SwiftUI

struct DetailsDescriptionRow: View {
    
    var textDescription: String

    init(textDescription: String) {
        self.textDescription = textDescription
    }
    
    var body: some View {
        HStack {
            Text(textDescription)
                .font(.system(size: 14))
        }
    }
}

struct DetailsDescriptionRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailsDescriptionRow(textDescription: "guy")
    }
}
