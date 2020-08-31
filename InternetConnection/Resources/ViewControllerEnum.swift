//
//  ViewControllerEnum.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import Foundation

enum ViewControllerEnum{
    
    case firstScreen
    case secondScreen
    case thirdScreen
    
    public func vcName() -> String{
        switch self {
        case .firstScreen:
            return "ViewController"
        case .secondScreen:
            return "SecondViewController"
        case .thirdScreen:
            return "ThirdViewController"
        }
    }
}

enum StoryboardEnum{
    
    case main
    
    public func storyboardName() -> String{
        switch self {
        case .main:
            return "Main"
        }
    }
}
