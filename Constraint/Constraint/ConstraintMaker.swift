//
//  ConstraintMaker.swift
//  Constraint
//
//  Created by  on 2018/1/6.
//  Copyright © 2018年 yunie. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public final class ConstraintMaker {

    public var item1:          ConstraintItem
    public var attribute1:     ConstraintAttribute
    public var item2:          ConstraintItem?
    public var attribute2:     ConstraintAttribute
    public var multiplier:     CGFloat = 1
    public var constant:       CGFloat = 0
    public var relationBy:     ConstraintRelation = .equal
    
    fileprivate var constants: [CGFloat] = []
    
    private var constraints:   [Int: Constraint] = [:]
    
    
    /// 约束管理器初始化
    ///
    /// - Parameters:
    ///   - item1: 待约束项
    ///   - attribute1: 待约束项的约束
    ///   - item2: 约束关联项
    ///   - attribute2: 约束关联项的约束
    ///   - mutiplier: 倍数
    ///   - constant: 差距
    ///   - relationBy: 关系
    private init(item1: ConstraintItem,
                 attribute1: ConstraintAttribute,
                 item2: ConstraintItem?,
                 attribute2: ConstraintAttribute,
                 mutiplier: CGFloat = 1,
                 constant: CGFloat = 0,
                 relationBy: ConstraintRelation = .equal ) {
        self.item1 = item1
        self.attribute1 = attribute1
        self.item2 = item2
        self.attribute2 = attribute2
        self.multiplier = mutiplier
        self.constant = constant
        self.relationBy = relationBy
        makeConstraint()
    }
    
    
    public func makeConstraint() {
        let _attribute1: [Attribute] = attribute1.layoutAttributes
        let _attribute2: [Attribute] = attribute2.layoutAttributes
        for (index, aAttribute) in _attribute1.enumerated() {
            var constantSign: CGFloat = 1
            if aAttribute == .top || aAttribute == .left {
                constantSign = -1
            }
            let constraint: Constraint = Constraint(item1: item1.item,
                                                    attribute: aAttribute,
                                                    relationBy: relationBy,
                                                    item2: item2?.item,
                                                    attributeTo: _attribute2[index],
                                                    multiplier: multiplier,
                                                    constant: constant * constantSign)
            let rawValue = aAttribute.rawValue
            constraints[rawValue] = constraint
        }
        let _constraints: [Constraint] = Array(constraints.values)
        Constraint.activate(_constraints)
    }
    
    public func remakeConstraint(item: ConstraintItem,
                                 attribute: ConstraintAttribute,
                                 associateConstraint: ConstraintMaker?) {
        demakeConstraint()
        item2 = associateConstraint?.item1
        attribute2 = associateConstraint!.attribute1
        relationBy = associateConstraint!.relationBy
        multiplier = associateConstraint!.multiplier
        constants = associateConstraint!.constants
        constant = associateConstraint!.constant
        makeConstraint()
    }
    
    public func demakeConstraint() {
        let _constraints: [Constraint] = Array(constraints.values)
        Constraint.deactivate(_constraints)
        constraints.removeAll()
    }
    
}

fileprivate extension ConstraintMaker {
    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     mutiplier: CGFloat,
                     constant: CGFloat) {
        self.init(item: item, attribute: attribute, mutiplier: mutiplier)
        self.constant = constant
    }
    
    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     constant: CGFloat,
                     relationBy: ConstraintRelation) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: nil,
                  attribute2: attribute,
                  mutiplier: 1,
                  constant: constant, relationBy: relationBy)
    }
    
    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     constants: [CGFloat],
                     relationBy: ConstraintRelation) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: nil,
                  attribute2: attribute,
                  mutiplier: 1,
                  constant: 0, relationBy: relationBy)
        
    }
}

public extension ConstraintMaker {
    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     mutiplier: CGFloat = 1) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: item,
                  attribute2: attribute)
        self.multiplier = mutiplier
    }

    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     associateConstraint: ConstraintMaker?,
                     relationBy: ConstraintRelation = .equal) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: associateConstraint!.item2,
                  attribute2: associateConstraint!.attribute2,
                  mutiplier: associateConstraint!.multiplier,
                  constant: associateConstraint!.constant,
                  relationBy: relationBy)
    }
}

// MARK: 运算符重载
// MARK: 等式的右运算
public func * (lhs: CGFloat, rhs: ConstraintMaker?) -> ConstraintMaker {
    return ConstraintMaker(item: rhs!.item1,
                           attribute: rhs!.attribute1,
                           mutiplier: lhs)
}

public func * (lhs: ConstraintMaker?, rhs: CGFloat) -> ConstraintMaker {
    return ConstraintMaker(item: lhs!.item1,
                           attribute: lhs!.attribute1,
                           mutiplier: rhs)
}

public func + (lhs: ConstraintMaker?, rhs: CGFloat) -> ConstraintMaker {
    return ConstraintMaker(item: lhs!.item1,
                           attribute: lhs!.attribute1,
                           mutiplier: 1,
                           constant: rhs)
}

public func - (lhs: ConstraintMaker?, rhs: CGFloat) -> ConstraintMaker {
    return ConstraintMaker(item: lhs!.item1,
                           attribute: lhs!.attribute1,
                           mutiplier: 1,
                           constant: -rhs)
}

// MARK: 比较运算符重载
infix operator <= : AssignmentPrecedence
public func <== (lhs: inout ConstraintMaker?, rhs: ConstraintMaker) {
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          associateConstraint: rhs,
                          relationBy: .lessThanOrEqual)
}

infix operator >= : AssignmentPrecedence
public func >== (lhs: inout ConstraintMaker?, rhs: ConstraintMaker) {
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          associateConstraint: rhs,
                          relationBy: .greaterThanOrEqual)
}

// MARK: 约束自身计算运算符
// 适用于width height等不用与其他视图关联的约束
public func === (lhs: inout ConstraintMaker?, rhs: CGFloat) {
    assert(lhs!.attribute1.isSubset(of: [.width, .height]),
           "Constraint === 运算符仅用于width height等不用与其他视图关联的约束")
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          constant: rhs,
                          relationBy: .equal)
}

public func === (lhs: inout ConstraintMaker?, rhs: CGSize) {
    assert(lhs!.attribute1.contains([.size]),
           "Constraint === 运算符仅用于size等不用与其他视图关联的约束")
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          constants: [rhs.height, rhs.height],
                          relationBy: .equal)
}

//v1.width <== 400 //自身的约束
infix operator <==: AssignmentPrecedence
public func <== (lhs: inout ConstraintMaker?, rhs: CGFloat) {
    assert(lhs!.attribute1.isSubset(of: [.width, .height]),
           "Constraint <== 运算符仅用于width height等不用与其他视图关联的约束")
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          constant: rhs,
                          relationBy: .lessThanOrEqual)
}

infix operator >==: AssignmentPrecedence
public func >== (lhs: inout ConstraintMaker?, rhs: CGFloat) {
    assert(lhs!.attribute1.isSubset(of: [.width, .height]),
           "Constraint >== 运算符仅用于width height等不用与其他视图关联的约束")
    lhs = ConstraintMaker(item: lhs!.item1,
                          attribute: lhs!.attribute1,
                          constant: rhs,
                          relationBy: .greaterThanOrEqual)
}

extension ConstraintMaker: CustomStringConvertible {
    public var description: String {
        return "被约束项\(item1.item) \n \t 约束\(attribute1.layoutAttributes)"
    }
}
