//
//  Home_Page.swift
//  iOS_Ultamite_FPL
//
//  Created by Mohammad Bakeer on 10/23/24.
//

import SwiftUI

struct Home_Page: View {
    var body: some View {
        VStack {
            // Title at the top
            Text("Poethunder")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)  // Add extra space above the title
                          
            // ZStack for layering images (field and shirt)
            ZStack {
                // Field Image from Assets folder
                Image("new-field")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 390, height: 550)
                    .clipped()
                
                // Arsenal shirt image on top
                Image("Arsenal")  // Assuming the Arsenal shirt image is named "arsenal-shirt" in your assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 90)  // Adjust size as needed
                    .position(x: 195, y: 275)  // Center the shirt on the field
            }
            
            Spacer()

            // Button to view the squad
            Button(action: {
                // Add your action here
            }) {
                Text("View Squad")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20) // Padding from the edges
            }
            
            Spacer() // Add some space at the bottom
        }
        .padding()
    }
}

struct Home_Page_Previews: PreviewProvider {
    static var previews: some View {
        Home_Page()
    }
}
