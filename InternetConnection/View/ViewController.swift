//
//  ViewController.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextBT : UIButton!
    
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
        self.title = "First Screen"
        
        // Setting up the next button
        nextBT.makeEdgesCircular()
        
        //Setup Netwok Listener
        NetworkManager.shared.networkDelegate = self
        
    }
    
    /*
    //MARK:- Observers
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateConnectionReachableStatus(_:)),
                                               name: NotificationCenterEnum.onlineConnected.getName(),
                                               object: nil)
    }
    
    //MARK:- Notification Observer Action Methods
    //Updating the label as per connection status
    @objc func updateConnectionStatus(_ notification : NSNotification){
        guard let connectionInfo = notification.userInfo else { return }
        
        DispatchQueue.main.async {
            if((connectionInfo["status"] as? Bool) ?? false){
                self.statusLabel.text = "We're Connected"
                NetworkManager.shared.pingHost(Endpoint.google.getDomainURL())
            }else{
                self.statusLabel.text = "We're not connected"
            }
        }
    }
    
    //Updating the label as per connection status
    @objc func updateConnectionReachableStatus(_ notification : NSNotification){
        guard let connectionInfo = notification.userInfo else { return }
        
        DispatchQueue.main.async {
            if((connectionInfo["connectionStatus"] as? Bool) ?? false){
                self.statusLabel.text = "We're Connected"
            }else{
                self.statusLabel.text = "We're connected but not reachable"
            }
        }
    }
    */
    
    //MARK:- IBAction Method
    @IBAction func nextBTAction(){
        print("Button Pressed")
        Router.navigateScreen(from: self, to: ViewControllerEnum.secondScreen.vcName())
    }
}

extension ViewController : NetworkConnectionStatus{
    func netwokResult(result: String) {
        DispatchQueue.main.async {
            self.statusLabel.text = result
        }
    }
}
