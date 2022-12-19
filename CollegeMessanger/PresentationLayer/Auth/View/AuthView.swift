//
//  AuthView.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 07.11.2022.
//

import SwiftUI

struct AuthView: View {
    @State private var goToRegistration = false
    @State private var email: String = ""
    @StateObject private var viewModel = AuthViewModelImpl()

    var body: some View {
        VStack {
            Spacer()

            buildTitle()

            Spacer()

            buildContent()
            
            buildButtons()

            Spacer()
        }
    }

    @ViewBuilder
    private func buildTitle() ->  some View {
        VStack {
            HStack {
                Text(Strings.collegeOfCommunication)
                    .font(.system(.title2))
                
                Asset.Assets.collegeLogo.swiftUIImage
            }
            
            Text(Strings.authorization)
        }
    }
    
    @ViewBuilder
    private func buildContent() -> some View {
        VStack {
            TextField(Strings.email, text: $viewModel.credentials.email)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField(Strings.password, text: $viewModel.credentials.password)
                .textFieldStyle(OvalTextFieldStyle())
        }
        .padding(.horizontal, 32)
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
    private func buildButtons() -> some View {
        VStack {
            AccentButton(title: Strings.authorization) {
                viewModel.login()
            }
            .padding(.horizontal, 32)
            
            AccentButton(title: Strings.registration,
                         backgroundColor: Asset.Colors.secondColor.swiftUIColor,
                         foregroundColor: Asset.Colors.accentColor.swiftUIColor) {
                goToRegistration.toggle()
            }
            .padding(.horizontal, 32)
            
            NavigationLink(destination: RegistrationView(), isActive: $goToRegistration, label: {
                EmptyView()
            })
            
            Button {
                ChatServiceImpl().getMessageForChat(chatID: "h3ZWZpdVWvwovhh3nsJs", messageID: "0efdbc6ee81744b2aa308a0b7aee1109") { message, error in
                    print(message!)
                }
            } label: {
                Text(Strings.forgotPassword)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
            .padding(.top, 4)

        }
        .padding(.top, 16)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
