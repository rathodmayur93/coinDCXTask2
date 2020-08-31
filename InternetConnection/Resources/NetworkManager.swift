//
//  NetworkManager.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import Foundation
import Network
import SystemConfiguration

protocol NetworkConnectionStatus {
    func netwokResult(result : String)
}

final public class NetworkManager{
    
    //MARK:- Variables
    private let monitor = NWPathMonitor()
    static let shared = NetworkManager()
    
    //Defining the delegate protocol to pass the data from the Network Manager to Calling View Controller
    var networkDelegate : NetworkConnectionStatus?
    
    //MARK:- /Computed Variables
    var status : String? {
        didSet{
            networkDelegate?.netwokResult(result: status ?? "")
        }
    }
    
    //MARK:- Initializer
    init() {
        checkConnection()
    }
    
    //MARK:- Setting Up Observers
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
    //Updating the status as per connection status
    @objc func updateConnectionStatus(_ notification : NSNotification){
        guard let connectionInfo = notification.userInfo else { return }
        
        DispatchQueue.main.async {
            if((connectionInfo["status"] as? Bool) ?? false){
                //self.statusLabel.text = "We're Connected"
                NetworkManager.shared.pingHost(Endpoint.google.getDomainURL())
            }else{
                //self.statusLabel.text = "We're not connected"
                self.status = "WE'RE NOT CONNECTED 2"
            }
        }
    }
    
    //Updating the status as per reachability status of connection
    @objc func updateConnectionReachableStatus(_ notification : NSNotification){
        guard let connectionInfo = notification.userInfo else { return }
        
        DispatchQueue.main.async {
            if((connectionInfo["connectionStatus"] as? Bool) ?? false){
                self.status = "WE'RE CONNECTED"
                //self.statusLabel.text = "We're Connected"
            }else{
                self.status = "WE'RE CONNECTED BUT NO CONNECTION"
                //self.statusLabel.text = "We're connected but not reachable"
            }
        }
    }
    
    //Check whether user is connected to internet or not
    public func checkConnection() {
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                self.pingHost(Endpoint.google.getDomainURL())
//                //Post notification to the observers
//                let connectionResult = ["status" : true]
//                NotificationCenter.default.post(name: NotificationCenterEnum.online.getName(),
//                                                object: nil,
//                                                userInfo: connectionResult)
            } else if path.status == .unsatisfied {
                self.status = "WE'RE NOT CONNECTED"
                //Post notification to the observers
//                let connectionResult = ["status" : false]
//                NotificationCenter.default.post(name: NotificationCenterEnum.offline.getName(),
//                                                object: nil,
//                                                userInfo: connectionResult)
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    //Ping host to check whether we are connected to internet or not
    func pingHost(_ fullURL: String) {
        
        let url = URL(string: fullURL)
        var connectionResult : [String : Bool]?
        
        let task = URLSession.shared.dataTask(with: url!) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                self.status = "WE'RE CONNECTED"
                print(httpResponse.statusCode)
                connectionResult = ["connectionStatus" : true]
            }else{
                self.status = "WE'RE CONNECTED BUT NO INTERNET CONNECTION"
                connectionResult = ["connectionStatus" : false]
            }
            
//            //Post notification to the observers
//            NotificationCenter.default.post(name: NotificationCenterEnum.onlineConnected.getName(),
//                                            object: nil,
//                                            userInfo: connectionResult)
        }
        
        task.resume()
    }
    
    //MARK:- Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationCenterEnum.online.getName(), object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenterEnum.offline.getName(), object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenterEnum.onlineConnected.getName(), object: nil)
    }
    
}
