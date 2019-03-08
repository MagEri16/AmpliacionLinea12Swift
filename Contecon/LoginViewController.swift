//
//  LoginViewController.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 22/01/18.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit
import IDZSwiftCommonCrypto



class LoginViewController: UIViewController, UITextFieldDelegate{
    var usuario: UITextField?
    var sendButton: UIButton?
    var alertMessage: String!
    let sessionManager = SessionManager.sharedInstance
    
    let inputContainerView = UIView()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let borderView = UIView()
    let secondBorderView = UIView()
    let loginButton = UIButton()
    var metroImage = UIImageView()
    let metroImage2 = UIImageView()
    
    let dummy_credentials = ["metro:linea12", "gbarrera:gbarrera", "prueba:prueba", "etungui:DGOP&2017", "consulta:DGCon2017"]
    var real_credentials = [String]()
    var grupoMovil = [String]()
    var usuarios = [User]()
    var servicePath = "http://www.calymayor.com.mx/sigoContecon/json/"
    var usersPath: String!
    var vistasPath: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = UIColor.white
        title = "Tren Maya"
        
        self.title = "Title"
        self.nameTextField.delegate = self
        self.nameTextField.autocorrectionType = .no
        self.nameTextField.autocapitalizationType = .none
        self.passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        usersPath = servicePath + "/usuarios/get.php"
        //vistasPath = servicePath + "/vistas/get.php"
        
        //view.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 155/255, alpha: 1.0)
        view.backgroundColor = UIColor.white
        navigationItem.title = "Tren Maya"
        
        let jsonManager = JSONManager()
        
        if Reachability.isConnectedToNetwork() == true {
            
            fillUpUsers(jsonPath: usersPath)
            print("Dentro del login-------")
            print (self.real_credentials.count)
        
        }
            
        else {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "Sin conexión a Internet", message: "Asegúrese que tenga acceso a internet y reinicie la aplicación", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        setupViews()
        
    }
    
    func setupViews() {
        inputContainerView.backgroundColor = UIColor.white
        inputContainerView.layer.cornerRadius = 5
        inputContainerView.layer.masksToBounds = true
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainerView)
        
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        //inputContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -30).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameTextField.placeholder = "Usuario"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 20).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 8).isActive = true
        
        //borderView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        //borderView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        borderView.backgroundColor = UIColor.lightGray
        borderView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(borderView)
        borderView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        borderView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        borderView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 8).isActive = true
        
        
        //secondBorderView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        secondBorderView.backgroundColor = UIColor.lightGray
        secondBorderView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(secondBorderView)
        secondBorderView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        secondBorderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        secondBorderView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        secondBorderView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        
        
        loginButton.setTitle("ENTRAR", for: .normal)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.backgroundColor = UIColor.gray
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1/2).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginButton.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 85).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 20).isActive = true
        loginButton.addTarget(self, action: #selector(LoginViewController.buttonPressed), for: .touchDown)
        
        
        metroImage.image = UIImage(named:"logo-contecon")
        metroImage.image = resizeImage(image: metroImage.image!, newWidth: 90)
        metroImage.contentMode = .top
        metroImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(metroImage)
        //new constraint
        metroImage.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -150).isActive = true
        
        metroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        metroImage.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -20).isActive = true
        metroImage.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        metroImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        /*--------------------------------------*/
        
        metroImage2.image = UIImage(named:"logo-cym")
        metroImage2.image = resizeImage(image: metroImage2.image!, newWidth: 90)
        metroImage2.contentMode = .top
        metroImage2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(metroImage2)
        //new constraint
        metroImage2.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -30).isActive = true
        
        metroImage2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        metroImage2.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -20).isActive = true
        metroImage2.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        metroImage2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    func buttonPressed() {
        
        print("Hello")
        print("Ahora estoy apretando el botón y tengo estos usuarios: ",usuarios.count)
        
        if(areValidFields()&&isConnectedToInternet()){
            if(validCredentials2(username: nameTextField.text!, password: passwordTextField.text!)){
                
                //Se establece el grupo móvil del usuario de sesión
                let grupoMovil = obtenerGrupoMovil(username: nameTextField.text!)
                print("Grupo móvil antes de ir a la pantalla principal: "+grupoMovil)
                self.sessionManager.setGrupoMovil(grupoMovil: grupoMovil)
                self.sessionManager.showMainScreen()
            }
            else{
                let var_users = self.real_credentials.count
                if(var_users > 0){
                    alertMessage = "Sus credenciales no son válidas"
                    showAlertWithMessage(alertMessage)
                }
                else{
                    fillUpUsers(jsonPath: self.usersPath)
                }
            }
        }
        else if(!areValidFields()){
            alertMessage = "Los campos no pueden estar vacíos"
            showAlertWithMessage(alertMessage)
        }
        else if(!isConnectedToInternet()){
            alertMessage = "Asegúrese de estar conectado a internet. Cierre y abra la aplicación nuevamente"
            showAlertWithMessage(alertMessage)
            
        }
    }
    
    
    func isConnectedToInternet() -> Bool {
        
        return Reachability.isConnectedToNetwork()
        
    }
    
    
    func areValidFields() -> Bool {
        
        let usuario = nameTextField.text
        let password = passwordTextField.text
        
        return !(usuario!.isEmpty || password!.isEmpty )    }
    
    
    
    func validCredentials(username: String, password: String) -> Bool {
        var valid = false
        for credential in dummy_credentials{
            let pieces = credential.components(separatedBy: ":")
            if(pieces[0] == username){
                print("El usuario es: "+username)
                valid = pieces[1] == password
            }
        }
        
        return valid
        
    }
    
    func validCredentials2(username: String, password: String) -> Bool {
        var valid = false
        let hash = password.MD5
        //print ("Hash-->" + hash)
        for credential in real_credentials{
            let pieces = credential.components(separatedBy: ":")
            if(pieces[0] == username){
                print("El usuario es: "+username)
                valid = pieces[1] == hash
                print ("VALID: ")
                print (valid)
            }
        }
        
        return valid
        
    }
    
    func obtenerGrupoMovil(username: String) -> String {
        var grupo = " "
        
        for grupoUsuario in grupoMovil{
            let pieces = grupoUsuario.components(separatedBy: ":")
            if(pieces[0] == username){
                print("El usuario es: "+username)
                grupo = pieces[1]
                print("Su grupo es:" + grupo)
            }
        }
        
        return grupo
    }
    
    func fillUpUsers(jsonPath: String){
        
        let jsonManager = JSONManager()
        
        jsonManager.downloadUsersFromAPI(withUrl: jsonPath) { responseObject, error in
            var usuariosMetro = [User]()
            
            usuariosMetro = responseObject!
            print("Usuarios: ",usuariosMetro.count)
            
            for i in 0 ..< Int((usuariosMetro.count)) {
                let user = usuariosMetro[i].usuario
                let password = usuariosMetro[i].password
                let grupoMovil = usuariosMetro[i].grupoMovil
                let dupla = user+":"+password
                let grupo = user+":"+grupoMovil
                self.real_credentials.append(dupla)
                self.grupoMovil.append(grupo)
            }
            
            print(self.real_credentials)
            print(self.grupoMovil)
            
            return
            
        }
        
    }
        
    
    func fillUpViews(jsonPath: String){
        
        let jsonManager = JSONManager()
        
        jsonManager.downloadViewsFromAPI(withUrl: jsonPath) { responseObject, error in
            var vistas = [View]()
            
            vistas = responseObject!
            print("Vistas: ",vistas.count)
            
            for i in 0 ..< Int((vistas.count)) {
                let vista = vistas[i].id
                let nombre = vistas[i].nombre
                let liga = vistas[i].liga
            }
            
            print(vistas)
            
            return
            
        }
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "One"
    }
    
    func showAlertWithMessage(_ message: String) {
        CVAlertController.alert("Aviso", message: message)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
}

