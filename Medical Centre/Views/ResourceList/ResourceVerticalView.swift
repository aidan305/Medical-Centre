//
//  ResourceListView.swift
//  Medical Centre
//
//  Created by aidan egan on 21/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage
import MapKit

struct ResourceVerticalView: View {
    
    @ObservedObject var resourceStore = ResourceStore()
    @State private var displayMap = true

    init(){
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
    }

    
    var body: some View {
        VStack(){
            HStack(spacing: -6){
                Button(action: {displayMap = false}, label: {
                    Text("List")
                        .foregroundColor(displayMap ? .black : .white)
                        .frame(width: UIScreen.screenWidth/2.1, height: 30)
                        .background(displayMap ? .white : Color("PrimaryBlue"))
                        .border(Color.black)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).stroke(Color(.init(white: 0, alpha: 0.5))))
                        
                })
                Button(action: {displayMap = true}, label: {
                    Text("On Map")
                        .foregroundColor(displayMap ? .white : .black)
                        .frame(width: UIScreen.screenWidth/2.1, height: 30)
                        .background(displayMap ? Color("PrimaryBlue") : .white)
                        .border(Color.black)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).stroke(Color(.init(white: 0, alpha: 0.5))))
                })
            }.shadow(radius: 5)
            .padding(.vertical)
            
            if displayMap == false {
                ResourceListView()
            } else if displayMap == true {
                VStack{
                    ResourceMapListView()
               }.padding(.bottom)
           }
        }.navigationBarTitle("Doctors", displayMode: .inline)
    }
}

struct ResourceVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ResourceVerticalView()
        }
    }
}
