//
//  HomeViewController.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit

class HomeViewController: MenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home")
        
        view.backgroundColor = UIColor.white
        print("Estoy en el home")
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "puente-inicio-junio")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        /*backgroundImage.contentMode = UIViewContentMode.scaleAspectFill*/
        /*backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)*/
        
        title = "Tren Maya"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
