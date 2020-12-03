//
//  PostViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/27/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol PostViewControllerDelegate {
    func postViewController(_ controller: PostViewController, didRegisterPost post: PostBE)
}

class PostViewController: UIViewController {
    
    @IBOutlet weak var txtPostContent                  : UITextField!
    @IBOutlet weak var txtUrlImage              : UITextField!
    @IBOutlet weak var constraintBottomScroll   : NSLayoutConstraint!
    
    var delegate: PostViewControllerDelegate?
    
    let user = Auth.auth().currentUser
    let likes = 0
    
    @IBAction func clickBtnSave(_ sender: Any) {
        
        guard let postText = self.txtPostContent.text, postText.count != 0 else {
            self.showAlertWithTitle("Error", message: "Ingrese un nombre", acceptButton: "Aceptar")
            return
        }
        
        guard let urlImage = self.txtUrlImage.text, urlImage.count != 0 else {
            self.showAlertWithTitle("Error", message: "Ingrese una imagen", acceptButton: "Aceptar")
            return
        }
        
         
        
        self.showAlertWithTitle("Agregar", message: "¿Deseas agregar este lugar?", acceptButton: "Aceptar", cancelButton: "Cancelar", acceptHandler: {
            
            let postRef = Database.database().reference().child("posts").childByAutoId()
            
            var userBE = UserBE(uid: self.user!.uid, email: self.user!.email!)
            
            let postObject = [
                "author": [
                    "uid": userBE.uid,
                    "email": userBE.email
                ],
                "text": self.txtPostContent.text!,
                "urlImage": self.txtUrlImage.text!
            ] as [String:Any]
            
            postRef.setValue(postObject, withCompletionBlock: { error, ref in
                if error == nil{
                    self.navigationController?.popViewController(animated: true)
                } else {
                    
                }
            })
            
        })
    
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.constraintBottomScroll.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
     
        let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
