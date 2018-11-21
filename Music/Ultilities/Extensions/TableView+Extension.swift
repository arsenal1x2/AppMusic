//
//  TableView+Extension.swift
//  Music
//
//  Created by LTT on 11/20/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

public protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }

extension UITableViewHeaderFooterView: ReusableView { }

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: NibLoadableView {
}

extension UITableView {
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
       // registerNib(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UITableViewHeaderFooterView>(aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueResuableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(" Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue header/footer view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}
