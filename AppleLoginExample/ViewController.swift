//
//  ViewController.swift
//  AppleLoginExample
//
//  Created by Fomagran on 2020/11/15.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    @IBOutlet weak var appleLoginButton: ASAuthorizationAppleIDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appleLoginButton.addTarget(self, action: #selector(ViewController.appleLogInButtonTapped), for: .touchDown)
        
    }
    
    @objc func appleLogInButtonTapped() {
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request = authorizationProvider.createRequest()
        request.requestedScopes = [.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerDelegate {
    
    //성공적으로 로그인을 완료했을 때
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }

        print("AppleID Credential Authorization: userId: \(appleIDCredential.user), \(String(describing: appleIDCredential.email))")
        
    }
    //에러가 있을 때
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleID Credential failed with error: \(error.localizedDescription)")
    }
}

//MARK: 애플 로그인 텍스트 프로바이딩
@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

