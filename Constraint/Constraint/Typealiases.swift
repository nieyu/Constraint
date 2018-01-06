//
//  Typealiases.swift
//  Constraint
//
//  Created by  on 2018/1/6.
//  Copyright © 2018Year yunie. All rights reserved.
//


#if os(iOS) || os(tvOS)
    import UIKit
        typealias View = UIView
        typealias Relation = NSLayoutRelation
        typealias Attribute = NSLayoutAttribute
        typealias Priority = UILayoutPriority
#else
    import AppKit
        typealias View = NSView
        typealias Relation = NSLayoutConstraint.Relation
        typealias Attribute = NSLayoutConstraint.Attribute
        typealias Priority = NSLayoutConstraint.Priority
#endif

