
import AOCLib
import Foundation
import RegexBuilder

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 161
	}

	func solveBExamples() -> Bool {
		solveB("Example3") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		
		let mulToken = Regex {
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
		
		var sum = 0
		lines.forEach { line in
			let matches = line.matches(of: mulToken)
			sum = sum + matches.reduce(0) { sum, match in
				let m1 = Int(match.output.1)!
				let m2 = Int(match.output.2)!
				return sum + m1 * m2
			}
		}
		return sum
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return lines.count
	}
}
