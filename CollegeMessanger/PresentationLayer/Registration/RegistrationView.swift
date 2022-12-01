//
//  RegistrationView.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject
    private var viewModel = RegistrationViewModelImpl()
    
    @Environment(\.presentationMode) var presentation
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            buildTitle()
            
            buildRegistrationContent()
                           
            buildRegistrationButton()
                .padding(.top, 16)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func buildTitle() -> some View {
        ZStack {
            HStack {
                Button {
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
            }
            
            Text(Strings.registration)
                .font(.system(.title2))
        }
    }

    @ViewBuilder
    private func buildRegistrationContent() -> some View {
        VStack (spacing: 16) {
            TextField(Strings.firstName, text: $viewModel.userDetails.firstName)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.lastName, text: $viewModel.userDetails.lastName)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.patronymic, text: $viewModel.userDetails.patronimyc)
                .textFieldStyle(OvalTextFieldStyle())
            
            DatePicker(Strings.birthday, selection: $viewModel.userDetails.birthday,
                       displayedComponents: [.date])
            .padding(10)
            .background(Asset.Colors.secondColor.swiftUIColor)
            .cornerRadius(16)
            
            TextField(Strings.group, text: $viewModel.userDetails.group)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.email, text: $viewModel.userDetails.email)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.phone, text: $viewModel.userDetails.phone)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.login, text: $viewModel.userDetails.login)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.password, text: $password)
                .textFieldStyle(OvalTextFieldStyle())
        }
        .padding(.horizontal, 32)
        // TODO: Add localization
        .alert(isPresented: $viewModel.hasErrors) {
            if case .failed(let error) = viewModel.state {
                return Alert(title: Text("Ошибка"),
                             message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Ошибка"),
                             message: Text("Что-то пошло не так"))
            }
        }
    }
    
    @ViewBuilder
    private func buildRegistrationButton() -> some View {
        AccentButton(title: Strings.register) {
            viewModel.registerUser(password: password)
        }
        .padding(.horizontal, 32)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Asset.Colors.secondColor.swiftUIColor)
            .cornerRadius(16)
    }
}
