//
//  NetflixHomeView.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-04-29.
//

import SwiftUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter : FilterModel? = nil
    @State private var fullHeaderSize : CGSize = .zero
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser : User? = nil
    @State private var productRows : [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical){
                VStack(spacing: 8){
                    
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCellData(product: heroProduct)
                    }
                    
                    categoryRows
                }
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    selectedFilter: selectedFilter,
                    filters: filters,
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    onXMarkPressed: {
                        selectedFilter = nil
                    }
                )
                .padding(.top, 16)
            }
            .background(Color.blue)
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }

        }
        .foregroundColor(.netflixWhite)
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            var rows : [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        }
        catch {
            
        }
    }
    
    private var header : some View {
        HStack(spacing : 0){
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16){
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    private func heroCellData(product : Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [product.category.capitalized, product.brand],
            onBackgroundPressed: {},
            onPlayPressed: {},
            onMyListPressed: {}
        )
        .padding(24)
    }
    
    private var categoryRows : some View {
        LazyVStack(spacing: 16){
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6){
                    Text(row.title)
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset){ (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRaking: rowIndex == 0 ? (index + 1) : nil
                                )
                            }
                        }
                        .padding(.leading, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    NetflixHomeView()
}
