
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example1") == 11
	}

	func solveBExamples() -> Bool {
		solveB("Example1") == 31
	}

	var answerA = "1651298"
	var answerB = "21306195"

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
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		var lhs: [Int] = []
		var rhs: [Int] = []
		for line in lines {
			lhs.append(Int(line[0])!)
			rhs.append(Int(line[3])!)
		}

		func rhsOccurrence(_ val: Int) -> Int {
			rhs.count { $0 == val }
		}
		
		var score = 0
		for val in lhs {
			score += val * rhsOccurrence(val)
		}
		return score
	}
}
