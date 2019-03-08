//
//  MenuViewController.swift
//  ReconstruccionCDMX
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isShowing: Bool = false
    let manager = SessionManager.sharedInstance
    
    var tableMenu = UITableView()
    let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 155/255, alpha: 1.0)
        view.addCustomMenuShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(handleShowMenu))
        navigationController?.navigationBar.isTranslucent = false
        
        setupViews()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        //New backgroundColor
        //cell.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 155/255, alpha: 1.0)
        cell.backgroundColor = UIColor(red: 95/255, green: 96/255, blue: 77/255, alpha: 1.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.font.withSize(6)
        
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "ATENCIÓN A VIVIENDAS"
        //cell.textLabel?.font.withSize(6)
        case 1:
            cell.textLabel?.text = "VIALIDADES"
        case 2:
            cell.textLabel?.text = "AVE. PIRAÑA"
        case 3:
            cell.textLabel?.text = "CARRETERA XOCHIMILCO"
        case 4:
            cell.textLabel?.text = "U.H. TAXQUEÑA"
        case 5:
            cell.textLabel?.text = "DEMOLICIONES"
        case 6:
            cell.textLabel?.text = "SALIR"
        default:
            cell.textLabel?.text = "Sin clasificar"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let home = HomeViewController()
        let login = LoginViewController()
        let viviendas = ViviendasViewController()
        let vialidades = VialidadesViewController()
        let pirana = PiranaViewController()
        let xochimilco = XochiViewController()
        let taxquena = TaxquenaViewController()
        let demoliciones = DemolicionesViewController()
        
        
        
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(viviendas, animated: true)
        case 1:
            self.navigationController?.pushViewController(vialidades, animated: true)
        case 2:
            self.navigationController?.pushViewController(pirana, animated: true)
        case 3:
            self.navigationController?.pushViewController(xochimilco, animated: true)
            
        case 4:
            self.navigationController?.pushViewController(taxquena, animated: true)
            
        case 5:
            self.navigationController?.pushViewController(demoliciones, animated: true)
            
        case 6:
            manager.showLoginScreen()
            
        default:
            self.navigationController?.pushViewController(home, animated: true)
            
        }
        
        print(indexPath.section)
        
    }
    
    
    var rightAnchor: NSLayoutConstraint?
    
    func setupViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(menuView)
        
        rightAnchor = menuView.rightAnchor.constraint(equalTo: view.leftAnchor, constant : -10)
        rightAnchor?.isActive = true
        
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //menuView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        menuView.heightAnchor.constraint(equalToConstant: self.view.frame.height*0.60).isActive = true
        menuView.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.72).isActive = true
        
        tableMenu = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.72, height: self.view.frame.height*0.60))
        
        tableMenu.delegate = self
        tableMenu.dataSource = self
        //tableMenu.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 155/255, alpha: 1.0)
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
    
}
extension UIView{
    func addCustomMenuShadow(){
        self.layer.shadowOffset = CGSize(width: 5, height:self.frame.height)
        self.layer.shadowOpacity = 0.1
    }
}
