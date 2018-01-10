//
//  ConstraintItem.swift
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

public final class ConstraintItem {
    public enum Option: Int {
        case from = 1
        case to
    }
    
    public var item: Any
    public var option: Option = .from
    
    init(item: Any, option: Option) {
        self.item = item
        self.option = option
    }
}

extension ConstraintItem: CustomStringConvertible {
    public var description: String {
        return "ConstraintItem option: \(self.option)"
    }
}

