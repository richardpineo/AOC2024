
import AOCLib
import Foundation

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 3749
	}

	func solveBExamples() -> Bool {
		solveB("Example7") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input7").description
	}

	func solveB() -> String {
		solveB("Input7").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return lines.count
	}
	
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
