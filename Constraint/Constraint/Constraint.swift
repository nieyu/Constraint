//
//  Constraint.swift
//  Constraint
//
//  Created by  on 2018/1/6.
//  Copyright © 2018Year yunie. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public final class Constraint {
    private var item1        : Any
    private var attribute    : Attribute = .notAnAttribute
    private var relationBy   : ConstraintRelation = .equal
    
    private var item2        : Any? //关联约束控件
    private var attributeTo  : Attribute = .notAnAttribute
    private var multiplier   : CGFloat = 1
    private var constant     : CGFloat = 0
    public  var constraint   : NSLayoutConstraint?
    
    #if os(iOS) || os(tvOS)
    public init(item1: Any,
                attribute: NSLayoutAttribute,
                relationBy: ConstraintRelation,
                item2: Any?,
                attributeTo: NSLayoutAttribute,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0) {
        self.item1 = item1
        self.attribute = attribute
        self.relationBy = relationBy
        self.item2 = item2
        self.attributeTo = attributeTo
        self.multiplier = multiplier
        self.constant = constant
        generateConstraint()
    }

    #else
    public init(item1: Any,
                attribute: NSLayoutConstraint.Attribute,
                relationBy: ConstraintRelation,
                item2: Any?,
                attributeTo: NSLayoutConstraint.Attribute,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0) {
        self.item1 = item1
        self.attribute = attribute
        self.relationBy = relationBy
        self.item2 = item2
        self.attributeTo = attributeTo
        self.multiplier = multiplier
        self.constant = constant
        generateConstraint()
    }
    #endif

    
    
    private func generateConstraint() {

        constraint = NSLayoutConstraint(item: item1,
                                        attribute: attribute,
                                        relatedBy: relationBy.layoutRelation,
                                        toItem: item2,
                                        attribute: attributeTo,
                                        multiplier: multiplier,
                                        constant: constant)
//        activate()
    }
    
    class public func activate(_ constraints: [Constraint]) {
        let layoutConstraints: [NSLayoutConstraint] = constraints.map { return $0.constraint! }
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    class public func deactivate(_ constraints: [Constraint]) {
        let layoutConstraints: [NSLayoutConstraint] = constraints.map { return $0.constraint! }
        NSLayoutConstraint.deactivate(layoutConstraints)
    }
}
