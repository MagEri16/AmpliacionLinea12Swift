//
//  JSONManager.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct User{
    let idPersonal: String
    let nombre: String
    let usuario: String
    let password: String
    let grupoMovil: String
    
    init(json: [String: Any]) {
        //idPersonal = json["idPersonal"] as? Int ?? -1
        idPersonal = json["idPersonal"] as? String ?? ""
        nombre = json["nombre"] as? String ?? ""
        usuario = json["usuario"] as? String ?? ""
        password = json["password"] as? String ?? ""
        grupoMovil = json["grupomovil"] as? String ?? ""
    }
}

struct View{
    let id: String
    let nombre: String
    let liga: String
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? ""
        nombre = json["nombre"] as? String ?? ""
        liga = json["liga"] as? String ?? ""
    }
}

class JSONManager: NSObject {
    
    let jsonPath = "http://www.calymayor.com.mx/sigoContecon/json/usuarios/get.php"
    var users = [User]()
    var vistas = [View]()
    
    func requestWebService(_url_path:String) -> String {
        var jsonResponse = ""
        
        Alamofire.request(jsonPath).responseJSON { response in
            print(response.request!)  // original URL request
            print(response.response!) // HTTP URL response
            print(response.data!)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                jsonResponse = JSON as! String
                
            }
        }
        
        return jsonResponse
    }
    
    func downloadUsersFromAPI(withUrl url: String, completionHandler: @escaping ([User]?, NSError?) -> ()) {
        
        networkRequestUsers(withUrl: url, completionHandler: completionHandler)
        
    }
    
    func networkRequestUsers(withUrl url: String, completionHandler: @escaping ([User]?, NSError?) -> ()) {
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
                
            case .success:
                var usuarios = [User]()
                usuarios = self.parseUsersData(JSONData: response.data!)
                completionHandler(usuarios, nil)
                print(response.data!)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
        
    }
    
    func parseUsersData(JSONData: Data) ->[User] {
        
        var usuarios = [User]()
        do {
            
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options:.mutableContainers) as! NSArray
            
            print(readableJSON)
            
            for eachFetchedUser in readableJSON {
                let eachUser = eachFetchedUser as! [String: Any]
                let idPersonal = eachUser["idPersonal"] as! String
                let nombre = eachUser["nombre"] as! String
                let usuario = eachUser["usuario"] as! String
                let password = eachUser["password"] as! String
                let grupomovil = eachUser["grupomovil"] as! String
                
                let user = User(json: eachUser)
                
                print("idPersonal ",user.idPersonal)
                print("Nombre",user.nombre)
                print("usuario",user.usuario)
                print("password",user.password)
                print("grupoMovil",user.grupoMovil)
                
                usuarios.append(user)
                
                
                print("Usuarios------ ", usuarios.count)
                
            }
            
        }
        catch {
            print(error)
        }
        print("Usuarios al final del método------ ", usuarios.count)
        
        return usuarios
    }
    
    /*-----------------Funciones para obtener las vistas-------------*/
    
    func downloadViewsFromAPI(withUrl url: String, completionHandler: @escaping ([View]?, NSError?) -> ()) {
        
        networkRequestViews(withUrl: url, completionHandler: completionHandler)
        
    }
    
    func networkRequestViews(withUrl url: String, completionHandler: @escaping ([View]?, NSError?) -> ()) {
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
                
            case .success:
                var vistas = [View]()
                vistas = self.parseViewsData(JSONData: response.data!)
                completionHandler(vistas, nil)
                print(response.data!)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
        
    }
    
    func parseViewsData(JSONData: Data) ->[View] {
        
        var vistas = [View]()
        do {
            
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options:.mutableContainers) as! NSArray
            
            //print(readableJSON)
            
            for eachFetchedView in readableJSON {
                let eachView = eachFetchedView as! [String: Any]
                let idPersonal = eachView["id"] as! String
                let nombre = eachView["nombre"] as! String
                let liga = eachView["liga"] as! String
               
                let vista = View(json: eachView)
                
                //print("id",vista.id)
                //print("Nombre",vista.nombre)
                //print("liga",vista.liga)
               
                
                vistas.append(vista)
                
            }
            
        }
        catch {
            print(error)
        }
        
        return vistas
    }
    
    
    
}

