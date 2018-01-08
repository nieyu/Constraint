//
//  UIView+Extension(ConstraintMaker).swift
//  ConstraintMaker
//
//  Created by  on 2018/1/6.
//  Copyright © 2018Year yunie. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public extension View {

    var left: ConstraintMaker? {
        set {
            StoredProperty.left?.demakeConstraint()
            if newValue == nil {
                StoredProperty.left = newValue
            } else {
                StoredProperty.left = ConstraintMaker(item: itemFrom, attribute: .left, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .left) }
    }
    
    var top: ConstraintMaker? {
        set {
            StoredProperty.top?.demakeConstraint()
            if newValue == nil {
                StoredProperty.top = newValue
            } else {
                StoredProperty.top = ConstraintMaker(item: itemFrom, attribute: .top, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .top) }
    }
    
    var right: ConstraintMaker? {
        set {
            StoredProperty.right?.demakeConstraint()
            if newValue == nil {
                StoredProperty.right = newValue
            } else {
                StoredProperty.right = ConstraintMaker(item: itemFrom, attribute: .right, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .right) }
    }
    
    var bottom: ConstraintMaker? {
        set {
            StoredProperty.bottom?.demakeConstraint()
            if newValue == nil {
                StoredProperty.bottom = newValue
            } else {
                StoredProperty.bottom = ConstraintMaker(item: itemFrom, attribute: .bottom, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .bottom) }
    }
    
    var leading: ConstraintMaker? {
        set {
            StoredProperty.leading?.demakeConstraint()
            if newValue == nil {
                StoredProperty.leading = newValue
            } else {
                StoredProperty.leading = ConstraintMaker(item: itemFrom, attribute: .leading, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .leading) }
    }
    
    var trailing: ConstraintMaker? {
        set {
            StoredProperty.trailing?.demakeConstraint()
            if newValue == nil {
                StoredProperty.trailing = newValue
            } else {
                StoredProperty.trailing = ConstraintMaker(item: itemFrom, attribute: .trailing, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .trailing) }
    }
    
    var width: ConstraintMaker? {
        set {
            StoredProperty.width?.demakeConstraint()
            if newValue == nil {
                StoredProperty.width = newValue
            } else {
                StoredProperty.width = ConstraintMaker(item: itemFrom, attribute: .width, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .width) }
    }
    
    var height: ConstraintMaker? {
        set {
            StoredProperty.height?.demakeConstraint()
            if newValue == nil {
                StoredProperty.height = newValue
            } else {
                StoredProperty.height = ConstraintMaker(item: itemFrom, attribute: .height, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .height) }
    }
    
    var centerX: ConstraintMaker? {
        set {
            StoredProperty.centerX?.demakeConstraint()
            if newValue == nil {
                StoredProperty.centerX = newValue
            } else {
                StoredProperty.centerX = ConstraintMaker(item: itemFrom, attribute: .centerX, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .centerX) }
    }
    
    var centerY: ConstraintMaker? {
        set {
            StoredProperty.centerY?.demakeConstraint()
            if newValue == nil {
                StoredProperty.centerY = newValue
            } else {
                StoredProperty.centerY = ConstraintMaker(item: itemFrom, attribute: .centerY, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .centerY) }
    }
    
    var edges: ConstraintMaker? {
        set {
            StoredProperty.edges?.demakeConstraint()
            if newValue == nil {
                StoredProperty.edges = newValue
            } else {
                StoredProperty.edges = ConstraintMaker(item: itemFrom, attribute: .edges, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .edges) }
    }
    
    var size: ConstraintMaker? {
        set {
            StoredProperty.size?.demakeConstraint()
            if newValue == nil {
                StoredProperty.size = newValue
            } else {
                StoredProperty.size = ConstraintMaker(item: itemFrom, attribute: .size, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .size) }
    }
    
    var centre: ConstraintMaker? {
        set {
            StoredProperty.centre?.demakeConstraint()
            if newValue == nil {
                StoredProperty.centre = newValue
            } else {
                StoredProperty.centre = ConstraintMaker(item: itemFrom, attribute: .center, associateConstraint: newValue)
            }
        }
        get { return ConstraintMaker(item: itemTo, attribute: .center) }
    }
}

fileprivate extension View {
    struct StoredProperty {
        static var left:        ConstraintMaker? = nil
        static var top:         ConstraintMaker? = nil
        static var right:       ConstraintMaker? = nil
        static var bottom:      ConstraintMaker? = nil
        static var leading:     ConstraintMaker? = nil
        static var trailing:    ConstraintMaker? = nil
        static var width:       ConstraintMaker? = nil
        static var height:      ConstraintMaker? = nil
        static var centerX:     ConstraintMaker? = nil
        static var centerY:     ConstraintMaker? = nil
        
        static var edges:       ConstraintMaker? = nil
        static var size:        ConstraintMaker? = nil
        static var centre:      ConstraintMaker? = nil
        
        
        static var ConstraintMakers: [Int: ConstraintMaker] = [:]
    }
    
    fileprivate var itemFrom: ConstraintItem {
        return ConstraintItem(item: self, option: .from)
    }
    fileprivate var itemTo: ConstraintItem {
        return ConstraintItem(item: self, option: .to)
    }
}

