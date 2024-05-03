//
//  NetflixDetailsView.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-05-03.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailsView: View {
    
    @Environment(\.router) var router
    
    var product : Product = .mock
    
    @State private var progress : Double = 0.2
    @State private var isMyList : Bool = false
    @State private var products : [Product] = []
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.2).ignoresSafeArea()
            
            
            VStack(spacing: 0){
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed: {
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical){
                    VStack(alignment : .leading, spacing : 16){
                        
                        detailsProductSection
                        
                        bottomsSection
                        
                        productGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }.task {
             await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        
        do {
            products = try await DatabaseHelper().getProducts()
        }
        catch {
            
        }
    }
    
    private var detailsProductSection : some View {
        NetflixDetailsProductView(
            title: product.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 4,
            hasClosedCaptions: true,
            isTopTen: 5,
            descriptionText: product.description,
            castText: "Cast : Josue Lubaki, Someone Else",
            onPlayPressed: {
                
            },
            onDownloadPressed: {
                
            }
        )
    }
    
    private func onProductPressed(product : Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(product: product)
        }
    }
    
    private var bottomsSection : some View {
        HStack(spacing : 32){
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                // do something with selection
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
    private var productGridSection : some View {
        VStack (alignment : .leading){
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                ForEach(products, id: \.id){ product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRaking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: product)
                    }
                }
            })
        }
        .foregroundColor(.netflixWhite)
    }
}

#Preview {
    RouterView { _ in
        NetflixDetailsView()
    }
}
