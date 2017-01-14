//
//  Anchorage.swift
//  Anchorage
//
//  Created by Rob Visentin on 2/6/16.
//
//  Copyright 2016 Raizlabs and other contributors
//  http://raizlabs.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public protocol LayoutAnchorType {}
extension NSLayoutDimension : LayoutAnchorType {}
extension NSLayoutXAxisAnchor : LayoutAnchorType {}
extension NSLayoutYAxisAnchor : LayoutAnchorType {}

public protocol LayoutAxisType {}
extension NSLayoutXAxisAnchor : LayoutAxisType {}
extension NSLayoutYAxisAnchor : LayoutAxisType {}

#if swift(>=3.0)

    // MARK: - Equality Constraints

@discardableResult public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalToConstant: rhs))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsEqualToEdges: rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsEqualToEdges: rhs)
}

@discardableResult public func == <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs))
}

@discardableResult public func >=<T: NSLayoutDimension>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutXAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >=<T: NSLayoutYAxisAnchor>(lhs: T, rhs: T) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult public func >= <T: NSLayoutDimension>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutXAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= <T: NSLayoutYAxisAnchor>(lhs: T, rhs: LayoutExpression<T>) -> NSLayoutConstraint {
    return activate(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return activate(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return activate(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> EdgeGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors>) -> EdgeGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> AxisGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult public func >= <T: LayoutAxisType, U: LayoutAxisType>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>>) -> AxisGroup {
    return lhs.activate(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: ComparisonPrecedence
}

infix operator ~: PriorityPrecedence

@discardableResult public func ~ (lhs: CGFloat, rhs: UILayoutPriority) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(constant: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: T, rhs: UILayoutPriority) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, priority: rhs)
}

@discardableResult public func ~ <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: UILayoutPriority) -> LayoutExpression<T> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

// MARK: Layout Expressions

@discardableResult public func * (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: rhs)
}

@discardableResult public func * (lhs: CGFloat, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: rhs, multiplier: lhs)
}

@discardableResult public func * (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier *= rhs
    return expr
}

@discardableResult public func * (lhs: CGFloat, rhs: LayoutExpression<NSLayoutDimension>) -> LayoutExpression<NSLayoutDimension> {
    var expr = rhs
    expr.multiplier *= lhs
    return expr
}

@discardableResult public func / (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    return LayoutExpression(anchor: lhs, multiplier: 1.0 / rhs)
}

@discardableResult public func / (lhs: LayoutExpression<NSLayoutDimension>, rhs: CGFloat) -> LayoutExpression<NSLayoutDimension> {
    var expr = lhs
    expr.multiplier /= rhs
    return expr
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: rhs)
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: lhs)
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant += rhs
    return expr
}

@discardableResult public func + <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant += lhs
    return expr
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: T, rhs: CGFloat) -> LayoutExpression<T> {
    return LayoutExpression(anchor: lhs, constant: -rhs)
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: T) -> LayoutExpression<T> {
    return LayoutExpression(anchor: rhs, constant: -lhs)
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: LayoutExpression<T>, rhs: CGFloat) -> LayoutExpression<T> {
    var expr = lhs
    expr.constant -= rhs
    return expr
}

@discardableResult public func - <T: LayoutAnchorType>(lhs: CGFloat, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    var expr = rhs
    expr.constant -= lhs
    return expr
}

#endif

public struct LayoutExpression<T : LayoutAnchorType> {

    var anchor: T?
    var constant: CGFloat
    var multiplier: CGFloat
    var priority: UILayoutPriority

    init(anchor: T? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - EdgeAnchorsProvider

public protocol AnchorGroupProvider {

    var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> { get }
    var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> { get }
    var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> { get }

}

extension AnchorGroupProvider {

    public var edgeAnchors: EdgeAnchors {
        return EdgeAnchors(horizontal: horizontalAnchors, vertical: verticalAnchors)
    }

}


extension UIView: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }

}

extension UIViewController: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: view.leadingAnchor, second: view.trailingAnchor)
    }
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topLayoutGuide.bottomAnchor, second: bottomLayoutGuide.topAnchor)
    }
    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: view.centerXAnchor, second: view.centerYAnchor)
    }

}

extension UILayoutGuide: AnchorGroupProvider {

    public var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    public var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    public var centerAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }

}

// MARK: - AnchorGroup

public struct AnchorPair<T: LayoutAxisType, U: LayoutAxisType>: LayoutAnchorType {
    private var first: T
    private var second: U

    init(first: T, second: U) {
        self.first = first
        self.second = second
    }

    public func activate(constraintsEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> AxisGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsLessThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> AxisGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsGreaterThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> AxisGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func constraints(forAnchors anchors: AnchorPair<T, U>?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> AxisGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        switch (first, anchors.first, second, anchors.second) {
            // Leading, trailing
        case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                  secondX as NSLayoutXAxisAnchor, otherSecondX as NSLayoutXAxisAnchor):
            return AxisGroup(first: builder.leadingBuilder(firstX, (otherFirstX + c) ~ priority),
                             second: builder.trailingBuilder(secondX, (otherSecondX - c) ~ priority))
            //Top, bottom
        case let (firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor,
                  secondY as NSLayoutYAxisAnchor, otherSecondY as NSLayoutYAxisAnchor):
            return AxisGroup(first: builder.topBuilder(firstY, (otherFirstY + c) ~ priority),
                             second: builder.bottomBuilder(secondY, (otherSecondY - c) ~ priority))
            //CenterX, centerY
        case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                  firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor):
            return AxisGroup(first: builder.leadingBuilder(firstX, (otherFirstX + c) ~ priority),
                             second: builder.topBuilder(firstY, (otherFirstY - c) ~ priority))
        default:
            preconditionFailure("Layout axes of constrained anchors must match.")
        }
    }
}

public struct EdgeAnchors: LayoutAnchorType {
    var horizontalAnchors: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>
    var verticalAnchors: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>

    init(horizontal: AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>, vertical: AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>) {
        self.horizontalAnchors = horizontal
        self.verticalAnchors = vertical
    }

    public func activate(constraintsEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeGroup {
        let builder = ConstraintBuilder(horizontal: ==, vertical: ==)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsLessThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: <=, top: <=, trailing: >=, bottom: >=, centerX: <=, centerY: <=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    public func activate(constraintsGreaterThanOrEqualToEdges anchor: EdgeAnchors?, constant c: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> EdgeGroup {
        let builder = ConstraintBuilder(leading: >=, top: >=, trailing: <=, bottom: <=, centerX: >=, centerY: >=)
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: builder)
    }

    func constraints(forAnchors anchors: EdgeAnchors?, constant c: CGFloat, priority: UILayoutPriority, builder: ConstraintBuilder) -> EdgeGroup {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        let horizontalConstraints = horizontalAnchors.constraints(forAnchors: anchors.horizontalAnchors, constant: c, priority: priority, builder: builder)
        let verticalConstraints = verticalAnchors.constraints(forAnchors: anchors.verticalAnchors, constant: c, priority: priority, builder: builder)
        return EdgeGroup(top: verticalConstraints.first,
                         leading: horizontalConstraints.first,
                         bottom: verticalConstraints.second,
                         trailing: verticalConstraints.second)
    }

}

// MARK: - ConstraintGroup

public struct EdgeGroup {

    public var top: NSLayoutConstraint
    public var leading: NSLayoutConstraint
    public var bottom: NSLayoutConstraint
    public var trailing: NSLayoutConstraint

    public var horizontal: [NSLayoutConstraint] {
        return [leading, trailing].flatMap { $0 }
    }

    public var vertical: [NSLayoutConstraint] {
        return [top, bottom].flatMap { $0 }
    }

    public var all: [NSLayoutConstraint] {
        return [top, leading, bottom, trailing].flatMap { $0 }
    }

}

public struct AxisGroup {

    public var first: NSLayoutConstraint
    public var second: NSLayoutConstraint

}

// MARK: - Constraint Builders

struct ConstraintBuilder {

    typealias Horizontal = (NSLayoutXAxisAnchor, LayoutExpression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint
    typealias Vertical = (NSLayoutYAxisAnchor, LayoutExpression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint

    var topBuilder: Vertical
    var leadingBuilder: Horizontal
    var bottomBuilder: Vertical
    var trailingBuilder: Horizontal
    var centerYBuilder: Vertical
    var centerXBuilder: Horizontal

    #if swift(>=3.0)
    init(horizontal: @escaping Horizontal, vertical: @escaping Vertical) {
        topBuilder = vertical
        leadingBuilder = horizontal
        bottomBuilder = vertical
        trailingBuilder = horizontal
        centerYBuilder = vertical
        centerXBuilder = horizontal
    }
    init(leading: @escaping Horizontal, top: @escaping Vertical, trailing: @escaping Horizontal,
         bottom: @escaping Vertical, centerX: @escaping Horizontal, centerY: @escaping Vertical) {
        leadingBuilder = leading
        topBuilder = top
        trailingBuilder = trailing
        bottomBuilder = bottom
        centerYBuilder = centerY
        centerXBuilder = centerX
    }
    #else
    init(horizontal: Horizontal, vertical: Vertical) {
        topBuilder = vertical
        leadingBuilder = horizontal
        bottomBuilder = vertical
        trailingBuilder = horizontal
        centerYBuilder = vertical
        centerXBuilder = horizontal
    }
    init(leading: Horizontal, top: Vertical, trailing: Horizontal, bottom: Vertical, centerX: Horizontal, centerY: Vertical) {
        leadingBuilder = leading
        topBuilder = top
        trailingBuilder = trailing
        bottomBuilder = bottom
        centerYBuilder = centerY
        centerXBuilder = centerX
    }
    #endif

}

// MARK: - Constraint Activation

func activate(constraint theConstraint: NSLayoutConstraint, withPriority priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    // Only disable autoresizing constraints on the LHS item, which is the one definitely intended to be governed by Auto Layout
    if let first = theConstraint.firstItem as? UIView {
        first.translatesAutoresizingMaskIntoConstraints = false
    }

    theConstraint.priority = priority
    theConstraint.isActive = true

    return theConstraint
}
