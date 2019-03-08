//
//  MenuViewController.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isShowing: Bool = false
    let manager = SessionManager.sharedInstance
    var vistas = [View]()
    var real_views = [View]()
    var servicePath = "http://www.calymayor.com.mx/sigoContecon/json/"
    var vistasPath: String!
    var grupoMovil: String!
    
    var tableMenu = UITableView()
    let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCustomMenuShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(handleShowMenu))
        navigationController?.navigationBar.isTranslucent = false
        grupoMovil = self.manager.obtenerGrupoMovil()
        
        print("Grupo Móvil dentro del viewDidLoad de MenuViewController---!!")
        print(grupoMovil);
        
        vistasPath = servicePath + "/vistas/get.php?grupomovil="+grupoMovil
        
        print(vistasPath)
        
        if Reachability.isConnectedToNetwork() == true {
            fillUpViews(jsonPath: vistasPath, completionClosure: { (views) in
                print ("Vistas desde Menu--------")
                self.real_views = views
                print(self.real_views)
                self.setupViews()
            })

        }
            
        else {
                print("Internet connection FAILED")
                var alert = UIAlertView(title: "Sin conexión a Internet", message: "Asegúrese que tenga acceso a internet y reinicie la aplicación", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
        }
            
        //setupViews()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return real_views.count + 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        //New backgroundColor
        //cell.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 155/255, alpha: 1.0)
        cell.backgroundColor = UIColor(red: 95/255, green: 96/255, blue: 77/255, alpha: 1.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.font.withSize(6)
        
            for i in 0 ..< self.real_views.count{
                if(indexPath.row == i){
                    cell.textLabel?.text = self.real_views[i].nombre
                }
            }
        
        if(indexPath.row == self.real_views.count){
            cell.textLabel?.text = "SALIR"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vista = GenericViewController()
        
        for i in 0 ..< self.real_views.count{
            if(indexPath.row == i){
                vista.myURL = self.real_views[i].liga
                print(self.real_views[i].liga)
                self.navigationController?.pushViewController(vista, animated: true)
            }
        }
        
        if(indexPath.row == self.real_views.count){
            manager.showLoginScreen()
        }
        
        print(indexPath.section)
        
    }
    
    
    var rightAnchor: NSLayoutConstraint?
    
    func setupViews(){
        
        var porcentaje: Float
        var rows = Float (real_views.count)
        porcentaje = rows / 6.5
        
        print("Porcentaje: %%%% ", porcentaje)
        self.view.backgroundColor = .white
        self.view.addSubview(menuView)
        
        rightAnchor = menuView.rightAnchor.constraint(equalTo: view.leftAnchor, constant : -10)
        rightAnchor?.isActive = true
        
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //menuView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        menuView.heightAnchor.constraint(equalToConstant: self.view.frame.height * CGFloat (porcentaje)).isActive = true
        menuView.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.70).isActive = true
        
        tableMenu = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.70, height: self.view.frame.height * CGFloat (porcentaje) ))
        
        /*tableMenu = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.72, height: self.view.frame.height*0.60))*/
        
        tableMenu.delegate = self
        tableMenu.dataSource = self
        //Change to new color
        tableMenu.backgroundColor = UIColor(red: 95/255, green: 96/255, blue: 77/255, alpha: 1.0)
        
        menuView.addSubview(tableMenu)
        
    }
    
    func handleShowMenu(){
        //drop the current right anchor
        rightAnchor?.isActive = false
        
        //assigning the new value and setting it active
        
        let constraintUpdate: NSLayoutConstraint = isShowing ? menuView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -10) : menuView.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.menuView.frame.width)
        
        rightAnchor = constraintUpdate
        rightAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseOut, animations: { self.view.layoutIfNeeded()} , completion: nil)
        
        isShowing = !isShowing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillUpViews(jsonPath: String, completionClosure: @escaping (_ vistas :[View])->Void) {
        let jsonManager = JSONManager()
        var vistasList = [View]()
        
        jsonManager.downloadViewsFromAPI(withUrl: jsonPath) { responseObject, error in
            vistasList = responseObject!
            print("Vistas: ",vistasList.count)
            print("Vistas: ",vistasList)
            
            for i in 0 ..< Int((vistasList.count)) {
                let vista = vistasList[i].id
                let nombre = vistasList[i].nombre
                let liga = vistasList[i].liga
                self.real_views.append(vistasList[i])
            }
            
            completionClosure(vistasList)
            
        }
        
    }
    
}
extension UIView{
    func addCustomMenuShadow(){
        self.layer.shadowOffset = CGSize(width: 5, height:self.frame.height)
        self.layer.shadowOpacity = 0.1
    }
}



