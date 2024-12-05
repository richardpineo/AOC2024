
import AOCLib
import Foundation

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example4") == 18
	}

	func solveBExamples() -> Bool {
		solveB("Example4") == 0
	}

	var answerA = "2639"
	var answerB = "0"

	func solveA() -> String {
		solveA("Input4").description
	}

	func solveB() -> String {
		solveB("Input4").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		return grid.allPositions.reduce(0) { count, pos in
			if grid.value(pos) != "X" {
				return count
			}
			
			let attempts = [
				[pos.offset(-1, -1), pos.offset(-2, -2), pos.offset(-3, -3)],
				[pos.offset(-1, 0), pos.offset(-2, 0), pos.offset(-3, 0)],
				[pos.offset(-1, 1), pos.offset(-2, 2), pos.offset(-3, 3)],

				[pos.offset(0, -1), pos.offset(0, -2), pos.offset(0, -3)],
				[pos.offset(0, 1), pos.offset(0, 2), pos.offset(0, 3)],

				[pos.offset(1, -1), pos.offset(2, -2), pos.offset(3, -3)],
				[pos.offset(1, 0), pos.offset(2, 0), pos.offset(3, 0)],
				[pos.offset(1, 1), pos.offset(2, 2), pos.offset(3, 3)]
			]
			
			let numXmas = attempts.reduce(0) { count, attempt in
				let passed =
				attempt.allSatisfy { grid.valid($0) } &&
					grid.value(attempt[0]) == "M" &&
					grid.value(attempt[1]) == "A" &&
					grid.value(attempt[2]) == "S"
				return passed ? count + 1 : count
			}
			return count + numXmas
		}
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
