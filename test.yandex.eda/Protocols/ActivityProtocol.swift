//
//  ActivityProtocol.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import UIKit

protocol ActivityProtocol: class{
    var activityView: UIView { get }
    var identifier: String { get }
    func startActivity()
    func stopActivity()
}

extension ActivityProtocol where Self:UIViewController {
    
    var activityView: UIView{
        get {
            let view = UIView()
            let screen = UIScreen.main.bounds.size
            view.frame = CGRect(origin: CGPoint.zero, size: screen)
            view.backgroundColor = .black
            view.alpha = 0.6
            
            view.restorationIdentifier = identifier
            
            let activity = UIActivityIndicatorView()
            activity.activityIndicatorViewStyle = .whiteLarge
            let x = (screen.width - activity.bounds.width) / 2
            let y = (screen.height - activity.bounds.height) / 2
            activity.frame = CGRect(origin: CGPoint(x: x, y: y), size: activity.bounds.size)
            activity.startAnimating()
            view.addSubview(activity)
            
            return view
        }
    }
    
    var identifier: String{
        get { return "ActivityIndicatorViewContainer" }
    }
    
    func startActivity(){
        view.addSubview(activityView)
    }
    
    func stopActivity(){
        for item in view.subviews where item.restorationIdentifier == identifier {
            item.removeFromSuperview()
            break
        }
    }
}
