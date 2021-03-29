//
//  LoginViewModel.swift
//  YourMovie
//
//  Created by Fam Van Anh on 22.03.21.
//  Copyright © 2021 Fam Van Anh. All rights reserved.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject {
    let viewRouter:ViewRouter!
    
    init(router:ViewRouter) {
        self.viewRouter = router
    }
    
    @Published var userName = "user123" {
        didSet {
            self.changeLoginButtonState()
        }
    }
    
    @Published var userPass = String() {
        didSet{
            self.changeLoginButtonState()
        }
    }
    
    @Published var isLoginEnable = false
    @Published var isLoginAlertShown = false

    private func changeLoginButtonState(){
        if (userName.count > 0 && userPass.count > 0) {
            self.isLoginEnable = true
        }
        else{
            self.isLoginEnable = false
        }
    }
    
     func validateLoginButton() {
        if (userName.lowercased() == Config.testUserName && userPass.lowercased() == Config.testPassword) {
             viewRouter.currentPageId = .home
        }
        else{
            self.isLoginEnable = false
            self.isLoginAlertShown = true
        }
    }
    
}
