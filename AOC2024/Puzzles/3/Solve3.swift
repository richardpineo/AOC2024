
import AOCLib
import Foundation
import RegexBuilder

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 161
	}

	func solveBExamples() -> Bool {
		solveB("Example3") == 48
	}

	var answerA = "187833789"
	var answerB = ""

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}
	
	private let mulToken = Regex {
		One("mul(")
		Capture {
			OneOrMore(.digit)
		}
		One(",")
		Capture {
			OneOrMore(.digit)
		}
		One(")")
	}

	private func sumFor(_ input: String) -> Int {
		let matches = input.matches(of: mulToken)
		return matches.reduce(0) { sum, match in
			let m1 = Int(match.output.1)!
			let m2 = Int(match.output.2)!
			return sum + m1 * m2
		}
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return lines.reduce(0) { sum, line in
			return sum + sumFor(line)
		}
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return lines.count
	}
}
