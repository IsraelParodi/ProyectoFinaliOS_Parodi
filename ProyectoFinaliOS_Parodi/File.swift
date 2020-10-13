//
//  File.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 10/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit

class File: UIViewController {
   
    @IBOutlet weak var txtCarrer: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtLastNames: UITextField!
    @IBOutlet weak var txtNames: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    
    
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    @IBOutlet weak var buttonRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonRegister.layer.cornerRadius = 25.0
        buttonRegister.layer.masksToBounds = true
        buttonRegister.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.red)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        if let controller = segue.destination as? DatePickerViewController{
            controller.delegate = self
        }
    }
    
    @IBAction func tapToClose(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func errorStyle(toInput input: UITextField){

        input.layer.borderColor = UIColor.red.cgColor
        input.layer.borderWidth = 2
        input.layer.cornerRadius = 5
        input.layer.shadowRadius = 5
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc func keyboardWillShow(_ notificacion: Notification){
        let keyboardFrame = notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notificacion.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration){
            self.constraintBottomScroll.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notificacion: Notification){
        
            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        
    }
    
    @IBAction func btnFInishRegister(_ sender: Any) {
           
           if txtUser.text == "" {
               txtUser.placeholder = "INGRESA TU USUARIO"
               self.errorStyle(toInput: self.txtUser)
           }else {
               txtUser.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtPassword.text == "" {
               txtPassword.placeholder = "INGRESA TU CONTRASEÑA"
               self.errorStyle(toInput: self.txtPassword)
           }else {
               txtPassword.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtNames.text == "" {
               txtNames.placeholder = "INGRESA TUS NOMBRES"
               self.errorStyle(toInput: self.txtNames)
           }else {
               txtNames.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtLastNames.text == "" {
               txtLastNames.placeholder = "INGRESA TUS APELLIDOS"
               self.errorStyle(toInput: self.txtLastNames)
           }else {
               txtLastNames.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtConfirmPassword.text == "" {
               txtConfirmPassword.placeholder = "INGRESA TU CONTRASEÑA NUEVAMENTE"
               self.errorStyle(toInput: self.txtConfirmPassword)
           }else {
               txtConfirmPassword.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtAge.text == "" {
               txtAge.placeholder = "INGRESA TU EDAD"
               self.errorStyle(toInput: self.txtAge)
           }else {
               txtAge.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtEmail.text == "" {
               txtEmail.placeholder = "INGRESA TU CORREO ELECTRÓNICO"
               self.errorStyle(toInput: self.txtEmail)
           }else {
               txtEmail.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtCarrer.text == "" {
               txtCarrer.placeholder = "INGRESA TU CARRERA"
               self.errorStyle(toInput: self.txtCarrer)
           }else {
               txtCarrer.layer.borderColor = UIColor.white.cgColor
           }
           
       }
}

extension File: DatePickerViewControllerDelegate{
    func datePickerViewController(_ controller: DatePickerViewController, didDateSelect date: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        dateFormatter.locale = Locale(identifier: "es_PE")
        
        self.txtAge.text = dateFormatter.string(from: date )
    }
}

extension File: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if self.txtAge ==  textField{
            self.performSegue(withIdentifier: "DatePickerViewController", sender: nil)
            return false
        }
        return true
    }
}
