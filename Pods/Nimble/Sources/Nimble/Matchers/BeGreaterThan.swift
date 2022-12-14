/// A Nimble matcher that succeeds when the actual value is greater than the expected value.
public func beGreaterThan<T: Comparable>(_ expectedValue: T?) -> Predicate<T> {
    let errorMessage = "be greater than <\(stringify(expectedValue))>"
    return Predicate.simple(errorMessage) { actualExpression in
        guard let actual = try actualExpression.evaluate(), let expected = expectedValue else { return .fail }

        return PredicateStatus(bool: actual > expected)
    }
}

public func ><Exp: Expectation, T: Comparable>(lhs: Exp, rhs: T) where Exp.Value == T {
    lhs.to(beGreaterThan(rhs))
}

#if canImport(Darwin)
import enum Foundation.ComparisonResult

/// A Nimble matcher that succeeds when the actual value is greater than the expected value.
public func beGreaterThan<T: NMBComparable>(_ expectedValue: T?) -> Predicate<T> {
    let errorMessage = "be greater than <\(stringify(expectedValue))>"
    return Predicate.simple(errorMessage) { actualExpression in
        let actualValue = try actualExpression.evaluate()
        let matches = actualValue != nil
            && actualValue!.NMB_compare(expectedValue) == ComparisonResult.orderedDescending
        return PredicateStatus(bool: matches)
    }
}

public func ><Exp: Expectation, T: NMBComparable>(lhs: Exp, rhs: T?) where Exp.Value == T {
    lhs.to(beGreaterThan(rhs))
}

extension NMBPredicate {
    @objc public class func beGreaterThanMatcher(_ expected: NMBComparable?) -> NMBPredicate {
        return NMBPredicate { actualExpression in
            let expr = actualExpression.cast { $0 as? NMBComparable }
            return try beGreaterThan(expected).satisfies(expr).toObjectiveC()
        }
    }
}
#endif
