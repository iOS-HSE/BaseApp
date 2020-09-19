//
//  UIView+Ext.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 12.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
