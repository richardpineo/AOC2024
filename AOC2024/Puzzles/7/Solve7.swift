
import AOCLib
import Foundation
import RegexBuilder

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 3749
	}

	func solveBExamples() -> Bool {
		solveB("Example7") == 0
	}

	var answerA = "3351424677624"
	var answerB = ""

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
			guard let match = try? equationRegex.firstMatch(in: line) else{
				return nil
			}
			
			let value = Int(match.output.1)!
			let inputs = String(match.output.2).split(separator: " ").map { Int($0)! }
			return .init(value: value, components: inputs)
		}
	}
	
	func passes(_ equation: Equation) -> Bool {
		if equation.value < 0 {
			return false
		}
		if equation.components.count == 0 {
			return equation.value == 0
		}

		let last = equation.components.last!
		let newComponents = Array(equation.components.dropLast())
		
		// try both
		if passes(.init(value: equation.value - last, components: newComponents)) {
			return true
		}
		if !equation.value.isMultiple(of: last) {
			return false
		}
		if passes(.init(value: equation.value / last, components: newComponents)) {
			return true
		}
		return false
	}
	
	func solveA(_ fileName: String) -> Int {
		let equations = load(fileName: fileName)
		
		return equations.reduce(0) { sum, equation in
			let passed = passes(equation)
			// print("Equation with value \(equation.value) \(passed ? "Passed" : "Failed")")
			return sum + (passed ? equation.value : 0)
		}
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
