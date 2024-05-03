//
//  ShareButton.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-05-03.
//

import SwiftUI

struct ShareButton: View {
    
    var url : String = "https://github.com/josue-lubaki"
    
    @ViewBuilder
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing : 8){
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundColor(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ShareButton()
    }
}
