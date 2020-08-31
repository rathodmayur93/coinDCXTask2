//
//  Router.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import UIKit.UIViewController

struct Router{
    
    //MARK:- Navigate to the Movie Detail Screen
    static func navigateScreen(from controller : UIViewController, to viewControllerIdentifier : String){
        
        //Fetching the storyBoard and creating the MovieDetailViewController object
        let mainStoryboard         = UIStoryboard(name: StoryboardEnum.main.storyboardName(), bundle: Bundle.main)
        let vc : UIViewController  = mainStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        
        vc.modalPresentationStyle   = .fullScreen
        vc.modalTransitionStyle     = .crossDissolve
        
        //Navigate to the movie detail screen
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
