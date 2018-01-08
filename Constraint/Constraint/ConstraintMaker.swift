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
    public var mutiplier:      CGFloat = 1
    public var constant:       CGFloat = 0
    public var relationBy:     ConstraintRelation = .equal
    
    private var constants:     [CGFloat] = []
    
    public var constraints:    [Int: Constraint] = [:]
    
    
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
        self.mutiplier = mutiplier
        self.constant = constant
        self.relationBy = relationBy
    }
    
    
    public func makeConstraint() {
        
    }
    
    public func remakeConstraint() {
        
    }
    
    public func demakeConstraint() {
        
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
}

public extension ConstraintMaker {
    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     mutiplier: CGFloat = 1) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: item,
                  attribute2: attribute)
        self.mutiplier = mutiplier
    }

    convenience init(item: ConstraintItem,
                     attribute: ConstraintAttribute,
                     associateConstraint: ConstraintMaker?,
                     relationBy: ConstraintRelation = .equal) {
        self.init(item1: item,
                  attribute1: attribute,
                  item2: associateConstraint!.item2,
                  attribute2: associateConstraint!.attribute2,
                  mutiplier: associateConstraint!.mutiplier,
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
    lhs = ConstraintMaker(item: lhs!.item1, attribute: lhs!.attribute1, constant: rhs, relationBy: .equal)
}

infix operator <==: AssignmentPrecedence
public func <== (lhs: inout ConstraintMaker?, rhs: CGFloat) {
    lhs = ConstraintMaker(item: lhs!.item1, attribute: lhs!.attribute1, constant: rhs, relationBy: .lessThanOrEqual)
}

infix operator >==: AssignmentPrecedence
public func >== (lhs: inout ConstraintMaker?, rhs: CGFloat) {
    lhs = ConstraintMaker(item: lhs!.item1, attribute: lhs!.attribute1, constant: rhs, relationBy: .greaterThanOrEqual)
}

extension ConstraintMaker: CustomStringConvertible {
    public var description: String {
        return "输出"
    }
}
