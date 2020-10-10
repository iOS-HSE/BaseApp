//
//  Navigator.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit
import DependencyInjection

final class Navigator {

    static let shared = Navigator()
    
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .start:
            let vc = AutorizeVC()
            show(target: vc, sender: sender)
        @unknown default:
            break
        }
    }
    
    func show(target: UIViewController, sender: UIViewController) {
        target.hidesBottomBarWhenPushed = true
        if let nav = sender as? UINavigationController {
            nav.show(target, sender: sender)
        } else {
            if let nav = sender.navigationController {
                nav.pushViewController(target, animated: true)
            } else {
                sender.modalTransitionStyle = .crossDissolve
                sender.present(target, animated: true, completion: nil)
            }
        }
    }

}
