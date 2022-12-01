//
//  DropDownField.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 14.11.2022.
//

import SwiftUI

struct DropDownField: View {
    @State private var selection = ""
    @Binding var groups: [Group]
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(Strings.group)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Picker("Select a paint color", selection: $selection) {
                ForEach(groups, id: \.id) {
                    Text($0.name)
                }
            }
            .pickerStyle(.menu)
            .accentColor(.black)
        }
        .padding(10)
        .background(Asset.Colors.secondColor.swiftUIColor)
        .cornerRadius(16)
    }
}
