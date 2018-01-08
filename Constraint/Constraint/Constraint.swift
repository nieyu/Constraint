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
    private var attribute    : ConstraintAttribute = .none
    private var relationBy   : ConstraintRelation = .equal
    
    private var item2        : Any? //关联约束控件
    private var attributeTo  : ConstraintAttribute = .none
    private var multiplier   : CGFloat = 1
    private var constant     : CGFloat = 0
    private var constraint   : NSLayoutConstraint?
    
    public init(item1: Any,
                attribute: ConstraintAttribute,
                relationBy: ConstraintRelation,
                item2: Any?,
                attributeTo: ConstraintAttribute,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0) {
        self.item1 = item1
        self.attribute = attribute
        self.relationBy = relationBy
        self.item2 = item2
        self.attributeTo = attributeTo
        self.multiplier = multiplier
        self.constant = constant
    }
    
    private func generateConstraint() {
        let _attribute: Attribute = attribute.layoutAttributes.first!
        let _attributeTo: Attribute = attributeTo.layoutAttributes.first!
        constraint = NSLayoutConstraint(item: item1,
                                        attribute: _attribute,
                                        relatedBy: relationBy.layoutRelation,
                                        toItem: item2,
                                        attribute: _attributeTo,
                                        multiplier: multiplier,
                                        constant: constant)
    }
    
    private func activate() {
        if constraint != nil {
            NSLayoutConstraint.activate([constraint!])
        }
    }
    
    private func deactivate() {
        if constraint != nil {
            NSLayoutConstraint.deactivate([constraint!])
            attribute = .none
            relationBy = .equal
            item2 = nil
            attributeTo = .none
            multiplier = 1
            constant = 0
            constraint = nil 
        }
    }
}
