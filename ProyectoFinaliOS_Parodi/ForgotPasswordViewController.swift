//
//  ForgotPasswordViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 10/13/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var txtUsuario: UITextField!
    @IBAction func btnForgotPassword(_ sender: Any) {
        if txtForgotPassword.text == "" {
            txtForgotPassword.placeholder = "INGRESA TU CORREO ELECTRONICO"
            self.errorStyle(toInput: self.txtForgotPassword)
        }else {
            txtForgotPassword.layer.borderColor = UIColor.white.cgColor
        }
        
        if let usuario = txtUsuario.text{
            Auth.auth().sendPasswordReset(withEmail: usuario){
              (error) in
                if let error = error{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido al reestablecer la contraseña", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                let alert = UIAlertController(title: "Perfecto", message: "El correo de cambio de usuario ha sido enviado", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alert,animated: true, completion: nil)
            }
        }
    }
    @IBOutlet weak var txtForgotPassword: UITextField!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var constraintCenterYView: NSLayoutConstraint!
    @IBOutlet weak var buttonSendForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonSendForgotPassword.layer.cornerRadius = 25.0
        buttonSendForgotPassword.layer.masksToBounds = true
        buttonSendForgotPassword.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.red)
    }
    
  func errorStyle(toInput input: UITextField){

        input.layer.borderColor = UIColor.red.cgColor
        input.layer.borderWidth = 2
        input.layer.cornerRadius = 5
        input.layer.shadowRadius = 5
    }
    
    @IBAction func clickBtnCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        let keyboardOriginY = keyboardFrame.origin.y
        let finalPosYViewContent = self.viewContent.frame.origin.y + self.viewContent.frame.height
        
        var delta: CGFloat = 0
        let viewContentSpaceKeyboard: CGFloat = 10
        
        if keyboardOriginY < finalPosYViewContent {
            delta = keyboardOriginY - finalPosYViewContent - viewContentSpaceKeyboard
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.constraintCenterYView.constant = delta
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.constraintCenterYView.constant = 0
            self.view.layoutIfNeeded()
            
        }
    }
}

