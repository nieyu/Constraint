//
//  ConstraintRelation.swift
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

public enum ConstraintRelation: Int {
    case equal = 1
    case lessThanOrEqual
    case greaterThanOrEqual
    
#if os(iOS) || os(tvOS)
    public var layoutRelation: NSLayoutRelation {
        return generateLayoutRelation()
    }
#else
    public var layoutRelation: NSLayoutConstraint.Relation {
        return generateLayoutRelation()
    }
#endif
    
    private func generateLayoutRelation() -> Relation {
        switch self {
        case .equal:                return Relation.equal
        case .greaterThanOrEqual:   return Relation.greaterThanOrEqual
        case .lessThanOrEqual:      return Relation.lessThanOrEqual
        }
    }
}
