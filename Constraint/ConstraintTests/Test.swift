//
//  Test.swift
//  ConstraintTests
//
//  Created by  on 2018/1/7.
//  Copyright © 2018年 yunie. All rights reserved.
//

import XCTest
@testable import Constraint

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class Test: XCTestCase {
    
    let container: View = View()
    
    public override func setUp() {
        super.setUp()
    }
    
    public override func tearDown() {
        super.tearDown()
    }
    
    public func test() {
        let v1: View = View()
        let v2: View = View()
        container.addSubview(v1)
        container.addSubview(v2)
        v1.left = container.left * 2 + 20
        v1.left = 2 * container.right + 30
        v2.edges = container.edges - 20
        v1.left = nil
        v1.centre = v2.centre
        v1.width === 400.0
//        v1.width === 400 //自身的约束
//        v1.width <== 400 //自身的约束
//        v1.size === CGSize(width: 20, height: 30) //自身的约束
//        v1.edges ==< UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 4)
    }
    
}
