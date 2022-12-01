//
//  TextFie.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 14.11.2022.
//

import SwiftUI

struct TextFieldWithDate: View {
    @State private var isShowDatePicker = false
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Text("День рождения")
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                isShowDatePicker = true
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
            }
            
            if isShowDatePicker {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                                Text("date")
                            }
                .datePickerStyle(.graphical)
            }
        }
        .padding(10)
        .background(Asset.Colors.secondColor.swiftUIColor)
        .cornerRadius(16)
    }
}

