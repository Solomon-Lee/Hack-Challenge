//
//  AlertManager.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController,title: String,message: String?){
    
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            vc.present(alert,animated: true)
        }
    }
}

//MARK: - Show Validation Errors
extension AlertManager{
    
    public static func showInvalidEmailAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please Enter a valid email")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please Enter a valid password")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please Enter a valid username")
    }
    
}

//MARK: - Show Registration alerts
extension AlertManager{
    
    public static func showRegistrationErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error.localizedDescription)")
    }

}

//MARK: - Show Login alerts
extension AlertManager{
    
    public static func showSigninErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Error Signing in", message: nil)
    }
    
    public static func showSigninErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Error Signing in", message: "\(error.localizedDescription)")
    }
}

//MARK: - Show Log out alerts
extension AlertManager{
    
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot Password
extension AlertManager{
    
    public static func showPasswordResetSent(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

extension AlertManager{
    
    public static func showEmailSent(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Verification Email sent", message: nil)
    }
    
    public static func showEmailVerificationError(on vc: UIViewController, with message: String){
        self.showBasicAlert(on: vc, title: "Email didn't verified", message: message)
    }
}

//MARK: - Fetching User Errors
extension AlertManager{
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func showUnkownFetchingUserError(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
}




