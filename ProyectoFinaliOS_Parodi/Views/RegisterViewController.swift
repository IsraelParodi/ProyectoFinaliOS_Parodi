//
//  RegisterViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 10/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var txtCarrer: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtLastNames: UITextField!
    @IBOutlet weak var txtNames: UITextField!
    @IBOutlet weak var txtUser: UITextField!

    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    @IBOutlet weak var buttonRegister: UIButton!
    
    let datePicker = UIDatePicker()
    
    var selectedCountry: String?
    var countryList = ["Diseño Gráfico", "Diseño de interiores", "Animación Digital", "Comunicación audiovisual", "Administración", "Desarrollo de Software"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonRegister.layer.cornerRadius = 25.0
        buttonRegister.layer.masksToBounds = true
        buttonRegister.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.red)
        
        createDatePicker()
        
        createPickerView()
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    
        toolbar.setItems([doneBtn], animated: true)
        txtAge.inputAccessoryView = toolbar
        txtAge.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countryList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countryList[row]
        txtCarrer.text = selectedCountry
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        txtCarrer.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
    }
    
    @objc func action() {
       view.endEditing(true)
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        dateFormatter.locale = Locale(identifier: "es_PE")
        txtAge.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
           
           if txtAge.text == "" {
               txtAge.placeholder = "INGRESA TU EDAD"
               self.errorStyle(toInput: self.txtAge)
           }else {
               txtAge.layer.borderColor = UIColor.white.cgColor
           }
           
           if txtCarrer.text == "" {
               txtCarrer.placeholder = "INGRESA TU CARRERA"
               self.errorStyle(toInput: self.txtCarrer)
           }else {
               txtCarrer.layer.borderColor = UIColor.white.cgColor
           }
        
        if let email = txtEmail.text, let password = txtPassword.text{
            Auth.auth().createUser(withEmail: email, password: password){
              (user, error) in
                if error == nil && user != nil{
                    self.saveProfile(username: self.txtUser.text!, password: self.txtPassword.text!, email: self.txtEmail.text!, name: self.txtNames.text!, lastName: self.txtLastNames.text!, age: self.txtAge.text!, career: self.txtCarrer.text!) { (success) in
                        self.performSegue(withIdentifier: "Feed", sender: nil)
                    }
                } else{
                    let alertController = UIAlertController(title: "Error", message: "Creacion de cuenta sin exito", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    func saveProfile(username: String, password: String, email: String, name: String, lastName: String, age: String, career: String, completion: @escaping ((_ success: Bool)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username"  : username,
            "password"  : password,
            "email"     : email,
            "name"      : name,
            "lastName"  : lastName,
            "age"       : age,
            "carrer"    : career
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
}

