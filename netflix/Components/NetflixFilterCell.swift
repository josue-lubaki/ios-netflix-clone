//
//  NetflixFilterCell.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-04-29.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title : String = "Categories"
    var isDropDown : Bool = true
    var isSelected : Bool = false
    
    var body: some View {
        HStack(spacing: 4){
            Text(title)
            
            if isDropDown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(.netflixDarkGray)
                    .opacity(isSelected ? 1 : 0)

                Capsule(style: .circular)
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isSelected: true)
            NetflixFilterCell(isDropDown: false)
        }
    }
}
