//
//  SessionManager.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
    
    static let sharedInstance = SessionManager(grupoMovil: "O")
    let defaults = UserDefaults.standard
    var grupoMovil: String!
    
    // MARK: Configure Screens
    
    private init(grupoMovil: String){
        self.grupoMovil = grupoMovil;
    }
    
    public func setGrupoMovil(grupoMovil: String){
        self.grupoMovil = grupoMovil;
    }
    
    public func obtenerGrupoMovil() -> String {
        var grupo = " "
        grupo = self.grupoMovil;
        return grupo
    }
    
    
    
    func showMainScreen() {

        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.showMainScreen()
    }
    
    func showMainScreen2() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.showMainScreen2()
    }
    
    func showLoginScreen () {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.showLoginScreen()
    }
    
    func LogoutSession() {
        
        
    }
    
    
}

