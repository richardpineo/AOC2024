
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 2
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 0
	}

	var answerA = "257"
	var answerB = ""

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		
		var count = 0
		for line in lines {
			var ascending: Bool?

			let levels = line.map { Int($0)! }
			let safe = (0 ... levels.count - 2)
				.map { levels[$0] - levels[$0 + 1] }
				.allSatisfy {
					let isAscending = $0 > 0
					if ascending == nil {
						ascending = isAscending
					} else {
						if isAscending != ascending {
							return false
						}
					}
					let step = abs($0)
					return step >= 1 && step <= 3
				}
			count += safe ? 1 : 0
		}
		return count
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		return 0
	}
}
