//
//  ViewWithNib.swift
//  Allianz_Centre
//
//  Created by James Che on 20/11/18.
//

import Foundation
import UIKit
protocol ViewWithNib {
    
    static var nibName: String { get }
}

extension ViewWithNib {
    
    static var nibName: String { return String(describing: `self`) }
}

extension ViewWithNib where Self: UIView {
    
    static func nib(bundle: Bundle = .main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    static func loadFromNib(bundle: Bundle = .main, owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil, frame: CGRect? = nil) -> Self {
        for case let view as Self in nib(bundle: bundle).instantiate(withOwner: owner, options: options) {
            if let frame = frame { view.frame = frame }
            return view
        }
        fatalError("No object of class \(Self.self) in nib (named: \(nibName), bundle: \(String(describing: bundle)))")
    }
    
//    func addSubviewFromNib(bundle: Bundle = .main, options: [AnyHashable: Any]? = nil) {
//        guard let view = Self.nib(bundle: bundle).instantiate(withOwner: self, options: options).first as? UIView else {
//            return
//        }
//
//        view.frame = bounds
//        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
//        addSubview(view)
//    }
}
