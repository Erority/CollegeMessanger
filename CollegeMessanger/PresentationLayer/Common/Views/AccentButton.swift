//
//  AccentButton.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 10.11.2022.
//

import SwiftUI

struct AccentButton: View {
    
    var title: String
    var backgroundColor = Asset.Colors.accentColor.swiftUIColor
    var foregroundColor = Color.white
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundColor(foregroundColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}
