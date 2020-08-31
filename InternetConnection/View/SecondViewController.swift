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
        NetworkManager.shared.checkConnection()
    }
    
    //MARK:- UI Functions
    private func setUI(){
        
        //Setting up the navigation bar title
        self.title = "Second Screen"
        
        //Setting up the observer
        setupObserver()
        
        // Setting up the next button
        nextBT.makeEdgesCircular()
    }
    
    //Setting up the network observer
    private func setupObserver(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateConnectionStatus(_:)),
                                               name: NotificationCenterEnum.online.getName(),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateConnectionStatus(_:)),
                                               name: NotificationCenterEnum.offline.getName(),
                                               object: nil)
    }
    
    //Updating the label as per connection status
    @objc func updateConnectionStatus(_ notification : NSNotification){
        guard let connectionInfo = notification.userInfo else { return }
        
        DispatchQueue.main.async {
            if((connectionInfo["status"] as? Bool) ?? false){
                self.statusLabel.text = "We're Connected"
            }else{
                self.statusLabel.text = "We're not connected"
            }
        }
    }
    
    
    //MARK:- IBAction Method
    @IBAction func nextBTAction(_ sender: Any) {
        Router.navigateScreen(from: self, to: ViewControllerEnum.thirdScreen.vcName())
    }
}
