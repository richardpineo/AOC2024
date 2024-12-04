
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 2
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 4
	}

	var answerA = "257"
	var answerB = "328"

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	func isSafe(_ levels: [Int]) -> Bool {
		var ascending: Bool?
		return (0 ... levels.count - 2)
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
	}
	
	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		
		return lines.reduce(0) { count, line in
			let levels = line.map { Int($0)! }
			return count + (isSafe(levels) ? 1 : 0)
		}
	}

	func solveB(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName).filter { !$0.isEmpty }
		
		return lines.reduce(0) { count, line in
			let levels = line.map { Int($0)! }
			if isSafe(levels) {
				return count + 1
			}
			// Try removing the levels to see if one is safe.
			for index in 0 ..< levels.count  {
				var dup = levels
				dup.remove(at: index)
				if isSafe(dup) {
					return count + 1
				}
			}
			return count
		}
	}
}
