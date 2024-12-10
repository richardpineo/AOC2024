
import AOCLib
import Foundation
import RegexBuilder

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 3749
	}

	func solveBExamples() -> Bool {
		solveB("Example7") == 11387
	}

	var answerA = "3351424677624"
	var answerB = "204976636995111"

	func solveA() -> String {
		solveA("Input7").description
	}

	func solveB() -> String {
		solveB("Input7").description
	}

	private let equationRegex = Regex {
		Capture {
			OneOrMore(.digit)
		}
		One(": ")
		Capture {
			OneOrMore(.anyNonNewline)
		}
	}

	struct Equation {
		var value: Int
		var components: [Int]
	}

	func load(fileName: String) -> [Equation] {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		return lines.compactMap { line in
			guard let match = try? equationRegex.firstMatch(in: line) else {
				return nil
			}

			let value = Int(match.output.1)!
			let inputs = String(match.output.2).split(separator: " ").map { Int($0)! }
			return .init(value: value, components: inputs)
		}
	}

	func passes(_ equation: Equation, value: Int, tryConcatenate: Bool) -> Bool {
		if equation.value < value {
			return false
		}
		if equation.components.count == 0 {
			return equation.value == value
		}

		let first = equation.components.first!
		let newComponents = Array(equation.components.dropFirst())

		if value == 0 {
			return passes(.init(value: equation.value, components: newComponents), value: first, tryConcatenate: tryConcatenate)
		}

		// try both
		if passes(.init(value: equation.value, components: newComponents), value: value + first, tryConcatenate: tryConcatenate) {
			return true
		}
		if passes(.init(value: equation.value, components: newComponents), value: value * first, tryConcatenate: tryConcatenate) {
			return true
		}
		if tryConcatenate {
			let nextValue = Int(String(value) + String(first))!
			if passes(.init(value: equation.value, components: newComponents), value: nextValue, tryConcatenate: tryConcatenate) {
				return true
			}
		}
		return false
	}

	func solve(_ fileName: String, tryConcatenate: Bool) -> Int {
		let equations = load(fileName: fileName)

		return equations.reduce(0) { sum, equation in
			let passed = passes(equation, value: 0, tryConcatenate: tryConcatenate)
			// print("Equation with value \(equation.value) \(passed ? "Passed" : "Failed")")
			return sum + (passed ? equation.value : 0)
		}
	}

	func solveA(_ fileName: String) -> Int {
		solve(fileName, tryConcatenate: false)
	}

	func solveB(_ fileName: String) -> Int {
		solve(fileName, tryConcatenate: true)
	}
}
