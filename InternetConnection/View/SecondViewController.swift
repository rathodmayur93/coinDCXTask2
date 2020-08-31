//
//  SecondViewController.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextBT: UIButton!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the UI Functions
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Setting up the observer
        NetworkManager.shared.networkDelegate = self
        NetworkManager.shared.checkConnection()
    }
    
    //MARK:- UI Functions
    private func setUI(){
        
        //Setting up the navigation bar title
        self.title = "Second Screen"
        
        // Setting up the next button
        nextBT.makeEdgesCircular()
    }
    
    
    //MARK:- IBAction Method
    @IBAction func nextBTAction(_ sender: Any) {
        Router.navigateScreen(from: self, to: ViewControllerEnum.thirdScreen.vcName())
    }
}

//MARK:- Extension For Protocol NetworkConnectionStatus
extension SecondViewController : NetworkConnectionStatus{
    func netwokResult(result: NetworkStatus) {
        DispatchQueue.main.async {
            self.statusLabel.text = result.getStatusMessage()
        }
    }
}
