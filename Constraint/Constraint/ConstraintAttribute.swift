//
//  ConstraintAttribute.swift
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

public final class ConstraintAttribute: OptionSet {
    public private(set) var rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    convenience init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
    public init(nilLiteral: ()) {
        self.rawValue = 0
    }
    
    public static let none:         ConstraintAttribute = ConstraintAttribute(rawValue: 0)
    public static let left:         ConstraintAttribute = ConstraintAttribute(rawValue: 1)
    public static let top:          ConstraintAttribute = ConstraintAttribute(rawValue: 2)
    public static let right:        ConstraintAttribute = ConstraintAttribute(rawValue: 4)
    public static let bottom:       ConstraintAttribute = ConstraintAttribute(rawValue: 8)
    public static let leading:      ConstraintAttribute = ConstraintAttribute(rawValue: 16)
    public static let trailing:     ConstraintAttribute = ConstraintAttribute(rawValue: 32)
    public static let width:        ConstraintAttribute = ConstraintAttribute(rawValue: 64)
    public static let height:       ConstraintAttribute = ConstraintAttribute(rawValue: 128)
    public static let centerX:      ConstraintAttribute = ConstraintAttribute(rawValue: 256)
    public static let centerY:      ConstraintAttribute = ConstraintAttribute(rawValue: 512)
    public static let lastBaseline: ConstraintAttribute = ConstraintAttribute(rawValue: 1024)
    
    //merge attribute
    public static let edges:        ConstraintAttribute = ConstraintAttribute(rawValue: 15)
    public static let size:         ConstraintAttribute = ConstraintAttribute(rawValue: 192)
    public static let center:       ConstraintAttribute = ConstraintAttribute(rawValue: 768)
    
    public var rawValues: [Int] {
        var values: [Int] = []
        if self.contains(ConstraintAttribute.left) {
            values.append(1)
        }
        if self.contains(ConstraintAttribute.top) {
            values.append(2)
        }
        if self.contains(ConstraintAttribute.right) {
            values.append(4)
        }
        if self.contains(ConstraintAttribute.bottom) {
            values.append(8)
        }
        if self.contains(ConstraintAttribute.leading) {
            values.append(16)
        }
        if self.contains(ConstraintAttribute.trailing) {
            values.append(32)
        }
        if self.contains(ConstraintAttribute.width) {
            values.append(64)
        }
        if self.contains(ConstraintAttribute.height) {
            values.append(128)
        }
        if self.contains(ConstraintAttribute.centerX) {
            values.append(256)
        }
        if self.contains(ConstraintAttribute.centerY) {
            values.append(512)
        }
        if self.contains(ConstraintAttribute.lastBaseline) {
            values.append(1024)
        }
        return values
    }

#if os(iOS) || os(tvOS)
    public var layoutAttributes: [NSLayoutAttribute] {
        return generateLayoutAttribute()
    }
#else
    public var layoutAttributes: [NSLayoutConstraint.Attribute] {
        return generateLayoutAttribute()
    }
#endif
    
    private func generateLayoutAttribute() -> [Attribute] {
        var attrs: [Attribute] = []
        if self.contains(ConstraintAttribute.left) {
            attrs.append(Attribute.left)
        }
        if self.contains(ConstraintAttribute.top) {
            attrs.append(Attribute.top)
        }
        if self.contains(ConstraintAttribute.right) {
            attrs.append(Attribute.right)
        }
        if self.contains(ConstraintAttribute.bottom) {
            attrs.append(Attribute.bottom)
        }
        if self.contains(ConstraintAttribute.leading) {
            attrs.append(Attribute.leading)
        }
        if self.contains(ConstraintAttribute.trailing) {
            attrs.append(Attribute.trailing)
        }
        if self.contains(ConstraintAttribute.width) {
            attrs.append(Attribute.width)
        }
        if self.contains(ConstraintAttribute.height) {
            attrs.append(Attribute.height)
        }
        if self.contains(ConstraintAttribute.centerX) {
            attrs.append(Attribute.centerX)
        }
        if self.contains(ConstraintAttribute.centerY) {
            attrs.append(Attribute.centerY)
        }
        if self.contains(ConstraintAttribute.lastBaseline) {
            attrs.append(Attribute.lastBaseline)
        }
        return attrs
    }
}

public func + (lhs: ConstraintAttribute, rhs: ConstraintAttribute) -> ConstraintAttribute {
    return lhs.union(rhs)
}

public func += (left: inout ConstraintAttribute, right: ConstraintAttribute) {
    left.formUnion(right)
}

public func -= (left: inout ConstraintAttribute, right: ConstraintAttribute) {
    left.subtract(right)
}

public func == (lhs: ConstraintAttribute, rhs: ConstraintAttribute) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

