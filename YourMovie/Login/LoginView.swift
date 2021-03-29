//
//  LoginView.swift
//  YourMovie
//
//  Created by Fam Van Anh on 22.03.21.
//  Copyright © 2021 Fam Van Anh. All rights reserved.
//

import SwiftUI


// Login View for user

struct LoginView: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    @State var logoDrop = false
    @State var logoText = false
    
    var body: some View {
        NavigationView {
            VStack() {
                Logo(logoDrop:$logoDrop,logoText: $logoText)
                UserNameField(userNameString: $loginViewModel.userName)
                PasswordField(passwordString: $loginViewModel.userPass)
                LoginButton(loginViewModel: loginViewModel)
            }
              
           
            .padding(Constants.Styles.pagePadding50)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline:.now() + 1){
                    withAnimation{self.logoDrop.toggle()}
                }
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5){
                    withAnimation{self.logoText.toggle()}
                }
                
            }
                  
           
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel(router: ViewRouter()))
    }
}

//MARK:- UI Elements

struct Logo : View{ 
    @Binding var logoDrop: Bool
    @Binding var logoText:Bool
    var body: some View{
        VStack{
            Image("LOGO")
                .resizable()
                .frame(width: 95, height: 95)
                .offset(y:logoDrop ? 0 : -500 )
                .animation(.spring(response: 0.5, dampingFraction: 0.6))
            Image("TEXT")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2, height: 48)
                //                .offset(y:logoText ? 0 : 0 )
                .opacity(logoText ? 5:0)
                .animation(.linear)
            
            
        }
    }
}



struct UserNameField:View {
    var userNameString:Binding<String>
    var body:some View {
        TextField("Username", text: userNameString)
            .padding()
            .background(Constants.Colors.lightGray)
            .cornerRadius(Constants.Styles.smallCornerRadius)
            .padding(.bottom, Constants.Styles.bottomPadding20)
    }
}

struct PasswordField:View {
    var passwordString:Binding<String>
    var body:some View {
        SecureField("Password", text: passwordString)
            .padding()
            .background(Constants.Colors.lightGray)
            .cornerRadius(Constants.Styles.smallCornerRadius)
            .padding(.bottom, Constants.Styles.bottomPadding20)
    }
}

struct LoginButton:View{
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body:some View {
        
        Button(action: {
            self.loginViewModel.validateLoginButton()
        }) {
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(loginViewModel.isLoginEnable ? Constants.Colors.buttonBlue  : Constants.Colors.darkGray)
                .cornerRadius(Constants.Styles.largeCornerRadius)
        }
        .alert(isPresented: $loginViewModel.isLoginAlertShown) {
            Alert(title: Text("Invalid Credentails !!"), message: Text("Please login with valid username or password"), dismissButton: .default(Text("OK")))
        }
        .disabled(!loginViewModel.isLoginEnable)
        
    }
    
}
struct Constants {
    
    struct Colors {
        static let lightGray = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
        static let darkGray = Color(red: 169.0/255.0, green: 169.0/255.0, blue: 169.0/255.0, opacity: 1.0)
        static let buttonBlue = Color(red: 1.0/255.0, green: 141.0/255.0, blue: 184.0/255.0, opacity: 1.0)

    }
    
    struct Styles {
        static let smallCornerRadius:CGFloat = 5.0
        static let largeCornerRadius:CGFloat = 15.0
        static let bottomPadding20:CGFloat = 20
        static let pagePadding50:CGFloat = 50.0
    }
    
}

struct Config {
    static let testUserName = "user123"
    static let testPassword = "user123"
}




