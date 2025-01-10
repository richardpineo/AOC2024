
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example10") == 36
	}

	func solveBExamples() -> Bool {
		solveB("Example10") == 81
	}

	var answerA = "548"
	var answerB = "1252"

	func solveA() -> String {
		solveA("Input10").description
	}

	func solveB() -> String {
		solveB("Input10").description
	}

	func score(map: Grid2D, pos: Position2D, trail: [Position2D], peaks: inout
		Set<Position2D>, useRanking: Bool) -> Int
	{
		let current = Int(String(map.value(pos)))!
		if current == 9 {
			if !useRanking && peaks.contains(pos) {
				return 0
			}
			peaks.insert(pos)
			return 1
		}
		let neighbors = map.neighbors(pos, includePos: false)
		let nextSteps = neighbors.filter {
			map.valid($0) && Int(String(map.value($0))) == current + 1 && !trail.contains($0)
		}
		return nextSteps.reduce(0) { [trail] total, pos in
			total + score(map: map, pos: pos, trail: trail + [pos], peaks: &peaks, useRanking: useRanking)
		}
	}

	func solve(_ fileName: String, useRanking: Bool) -> Int {
		let map = Grid2D(fileName: fileName)
		let trailheads = map.allPositions.filter {
			map.value($0) == "0"
		}
		let total = trailheads.reduce(0) { total, pos in
			var peaks = Set<Position2D>()
			let trailScore = score(map: map, pos: pos, trail: [pos], peaks: &peaks, useRanking: useRanking)
			return total + trailScore
		}
		return total
	}

	func solveA(_ fileName: String) -> Int {
		solve(fileName, useRanking: false)
	}

	func solveB(_ fileName: String) -> Int {
		solve(fileName, useRanking: true)
	}
}
