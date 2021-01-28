//
//  ViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 2508--2020.
//  Copyright © 2020 Anton Verver. All rights reserved.
//


// Swift
//
// Add this to the header of your file, e.g. in ViewController.swift

import FBSDKLoginKit
import GoogleSignIn

// Add this to the body
class ViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    

    @IBOutlet var SignInGoogleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            // User is logged in on Google
        }
        else {
            GIDSignIn.sharedInstance()?.signIn()
        }
        
        GIDSignIn.sharedInstance().presentingViewController = self

        if let token = AccessToken.current, !token.isExpired {
                   let token = token.tokenString
                   let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                            parameters: ["fields": "email; name"],
                                                            tokenString: token,
                                                            version: nil,
                                                            httpMethod: .get)
                   request.start(completionHandler: { connection, result, error in
                       print("\(result)")
                   })
            
        }
        else {
            let loginButton = FBLoginButton()
            view.addSubview(loginButton)
            loginButton.frame = CGRect(x:16, y:400, width: view.frame.width - 32, height: 63)
            
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
        }
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "/me",
                                                 parameters: ["fields": "id, email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: { connection, result, error in
            print("\(result)")
        })
        print(result)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Uitgelogd van Facebook")
    }
}
