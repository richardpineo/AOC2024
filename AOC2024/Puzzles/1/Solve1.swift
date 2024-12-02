
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example1") == 11
	}

	func solveBExamples() -> Bool {
		solveB("Example1") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input1").description
	}

	func solveB() -> String {
		solveB("Input1").description
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		var lhs: [Int] = []
		var rhs: [Int] = []
		for line in lines {
			lhs.append(Int(line[0])!)
			rhs.append(Int(line[3])!)
		}
		
		lhs.sort()
		rhs.sort()
		
		var sum = 0
		for index in 0 ..< lhs.count {
			sum += abs(rhs[index] - lhs[index])
		}
		return sum
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return lines.count
	}
}
