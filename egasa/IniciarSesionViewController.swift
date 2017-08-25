//
//  IniciarSesionViewController.swift
//  egasa
//
//  Created by rosario on 7/27/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import Firebase


class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var usarioTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    @IBOutlet weak var imgEgasa: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgEgasa.image = UIImage(named: "logoegasa")
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        //self.performSegue(withIdentifier: "iniciarsesionSegue", sender: nil)
        Auth.auth().signIn(withEmail: usarioTextField.text!, password: contrasenaTextField.text!, completion: { (user, error) in
            print("Intentamos Iniciar Sesión")
            //self.contrasenaTextField.isSecureTextEntry = true
            if error != nil {
                print("Tenemos el siguiente error:\(error)")
                Auth.auth().createUser(withEmail: self.usarioTextField.text!, password: self.contrasenaTextField.text!, completion: { (user, error) in
                    print("Intentamos crear un usuario")
                    if error != nil{
                        print("Tenemos el siguiente error:\(error)")
                    }
                    else{
                        print("El usario fue creado exitosamente")
                        Database.database().reference().child("usuarios").child(user!.uid).child("email").setValue(user!.email)
                        self.performSegue(withIdentifier: "iniciarsesionSegue", sender: nil)
                    }
                })
            }else{
                print("Inicio de Sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionSegue", sender: nil)
            }
        })
    }
    
   

}
