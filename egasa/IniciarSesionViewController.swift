//
//  IniciarSesionViewController.swift
//  egasa
//
//  Created by rosario on 7/27/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit

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
        self.performSegue(withIdentifier: "iniciarsesionSegue", sender: nil)
    }
    
   

}
