//
//  ThirdViewController.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import UIKit

class ThirdViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextBT: UIButton!
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the UI
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK:- UI Functions
    private func setUI(){
        //Setting up the navigation bar title
        self.title = "Third Screen"
        
        // Setting up the next button
        nextBT.makeEdgesCircular()
    }
    
    //MARK:- IBAction Method
    @IBAction func nextBTAction(_ sender: Any) {
        //Router.navigateScreen(from: self, to: ViewControllerEnum.firstScreen.vcName())
    }
}
