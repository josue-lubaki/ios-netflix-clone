//
//  NetflixMovieCell.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-04-30.
//

import SwiftUI

struct NetflixMovieCell: View {
    
    var width : CGFloat = 90
    var height : CGFloat = 140
    var imageName : String = Constants.randomImage
    var title : String? = "Movie Title"
    var isRecentlyAdded : Bool = false
    var topTenRaking : Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing : -8) {
            
            if let topTenRaking {
                Text("\(topTenRaking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y : 20)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing : 0){
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .lineLimit(1)
                        .offset(y: 2)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)
                        
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundColor(.netflixWhite)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        ScrollView {
            VStack {
                NetflixMovieCell(isRecentlyAdded: true)
                NetflixMovieCell(isRecentlyAdded: false)
                NetflixMovieCell(isRecentlyAdded: true, topTenRaking: 2)
                NetflixMovieCell(isRecentlyAdded: false, topTenRaking: 2)
                NetflixMovieCell(isRecentlyAdded: true, topTenRaking: 10)
                NetflixMovieCell(isRecentlyAdded: false, topTenRaking: 10)
            }
        }
        .scrollIndicators(.hidden)
    }
}
