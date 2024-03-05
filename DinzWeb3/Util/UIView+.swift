//
//  UIView+.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import UIKit

protocol CellIdentifiable {
    static var identity: String { get }
}

extension UIView: CellIdentifiable {
    static var identity: String {
        return String(describing: self)
    }
}

import UIKit

extension UITableView {
    func dequeueCellAtIndexPath<T: UITableViewCell>(indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identity, for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }
}
