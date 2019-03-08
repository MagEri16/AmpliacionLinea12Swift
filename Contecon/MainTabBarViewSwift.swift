//
//  MainTabBarViewSwift.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 01/22/18.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import UIKit

class MainTabBarView: UITabBarController, UITabBarControllerDelegate {
    
    let sessionManager = SessionManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        configureTabBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureTabBar() {
        
        //Actualizado 12-07-18
        let tabBarItemHome =  UINavigationController(rootViewController:HomeViewGobernadoresController())
        let tabBarItemFavorites = UINavigationController(rootViewController: HomeViewGobernadoresController())
        let tabBarItemDirectory = UINavigationController(rootViewController: HomeViewGobernadoresController())
        let tabBarItemReports = UINavigationController(rootViewController: HomeViewGobernadoresController())
        let tabBarItemSettings = UINavigationController(rootViewController: HomeViewGobernadoresController())
        
        /*let elements = [tabBarItemHome, tabBarItemFavorites, tabBarItemDirectory, tabBarItemReports, tabBarItemSettings]*/
        let elements = [tabBarItemHome]
        self.viewControllers = elements
        
        let firstImage = UIImage(named: "home")?.withRenderingMode(.automatic)
        let firstImageTinted = firstImage?.withRenderingMode(.alwaysTemplate)
        
        let secondImage = UIImage(named: "favorites")?.withRenderingMode(.automatic)
        let secondImageTinted = secondImage?.withRenderingMode(.alwaysTemplate)
        
        let thirdImage = UIImage(named: "favorites")?.withRenderingMode(.automatic)
        let thirdImageTinted = thirdImage?.withRenderingMode(.alwaysTemplate)
        
        let fourthImage = UIImage(named: "favorites")?.withRenderingMode(.automatic)
        let fourthImageTinted = fourthImage?.withRenderingMode(.alwaysTemplate)
        
        let fifthImage = UIImage(named: "favorites")?.withRenderingMode(.automatic)
        let fifthImageTinted = fifthImage?.withRenderingMode(.alwaysTemplate)
        
        //tabBarItemHome.tabBarItem = UITabBarItem(
        
        tabBarItemHome.tabBarItem = UITabBarItem(
            title: "Home",
            image: firstImage,
            selectedImage: firstImageTinted)
        
        /*tabBarItemFavorites.tabBarItem = UITabBarItem(
         title: "P. Ejecutivo",
         image: secondImage,
         selectedImage: secondImageTinted)
         
         tabBarItemDirectory.tabBarItem = UITabBarItem(
         title: "Liberación Predios",
         image: thirdImage,
         selectedImage: thirdImageTinted)
         
         tabBarItemReports.tabBarItem = UITabBarItem(
         title: "Avance Obra",
         image: fourthImage,
         selectedImage: fourthImageTinted)
         
         tabBarItemSettings.tabBarItem = UITabBarItem(
         title: "Levantamientos Notariales",
         image: fifthImage,
         selectedImage: fifthImageTinted)*/
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
