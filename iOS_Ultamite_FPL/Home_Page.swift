//
//  Home_Page.swift
//  iOS_Ultimate_FPL
//
//  Created by Mohammad Bakeer on 10/23/24.
//

import SwiftUI

struct Home_Page: View {
    var body: some View {
        NavigationView {
            VStack {
                // Title at the top
                Text("Poethunder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)  // Add extra space above the title
                              
                // ZStack for layering images (field and shirts)
                ZStack {
                    // Field Image from Assets folder
                    Image("new-field")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 390, height: 550)
                        .clipped()
                    
                    // Player positions
                    VStack(spacing: 40) {
                        // Forward players
                        HStack(spacing: 50) {
                            ForEach(FWD.indices, id: \.self) { index in
                                PersonView(personName: FWD[index].name, shirtName: FWD[index].shirtName)
                            }
                        }
                        
                        // Midfield players
                        HStack(spacing: 40) {
                            ForEach(MID.indices, id: \.self) { index in
                                PersonView(personName: MID[index].name, shirtName: MID[index].shirtName)
                            }
                        }
                        
                        // Defensive players
                        HStack(spacing: 10) {
                            ForEach(DEF.indices, id: \.self) { index in
                                PersonView(personName: DEF[index].name, shirtName: DEF[index].shirtName)
                            }
                        }
                        
                        // Goalkeeper
                        HStack {
                            PersonView(personName: GK.name, shirtName: GK.shirtName)
                                .padding(.top, 20)
                        }
                    }
                }
                
                Spacer()

                // Button to view the squad
                NavigationLink(destination: Edit_Team_Page()) {
                    Text("View Squad")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct PersonView: View {
    var personName: String
    var shirtName: String
 
    var body: some View {
        VStack {
            ZStack {
                // Background Rectangle
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green.opacity(0.7))
                    .frame(width: 84, height: 90)

                // Inner Rectangle for shirt image
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 70, height: 18) // Adjusted height for shirt view
                    .offset(y: 10)

                // Shirt Image
                Image(shirtName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .offset(y: -15)

                // Player Name
                Text(personName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 60)
            }
        }
    }
}

struct Home_Page_Previews: PreviewProvider {
    static var previews: some View {
        Home_Page()
            .previewDevice("iPhone 14 Pro")
    }
}
