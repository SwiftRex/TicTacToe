import Foundation
import CoreML

public struct ProbabilityCalculator {
    public let calculate: ([Int]) -> Result<Double, Error>

    public init(_ calculator: @escaping ([Int]) -> Result<Double, Error>) {
        self.calculate = calculator
    }
}
