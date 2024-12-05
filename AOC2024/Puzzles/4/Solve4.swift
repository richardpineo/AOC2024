
import AOCLib
import Foundation

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example4") == 18
	}

	func solveBExamples() -> Bool {
		solveB("Example4") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input4").description
	}

	func solveB() -> String {
		solveB("Input4").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return lines.count
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return lines.count
	}
}
