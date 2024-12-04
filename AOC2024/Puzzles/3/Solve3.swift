
import AOCLib
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 0
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
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return lines.count
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return lines.count
	}
}
