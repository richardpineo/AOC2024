
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example10") == 36
	}

	func solveBExamples() -> Bool {
		solveB("Example10") == 0
	}

	var answerA = "548"
	var answerB = ""

	func solveA() -> String {
		solveA("Input10").description
	}

	func solveB() -> String {
		solveB("Input10").description
	}

	func score(map: Grid2D, pos: Position2D, trail: [Position2D], peaks: inout
	Set<Position2D>) -> Int {
		let current = Int(String(map.value(pos)))!
		if current == 9 {
			if peaks.contains(pos) {
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
			total + score(map: map, pos: pos, trail: trail + [pos], peaks: &peaks)
		}
	}

	func solveA(_ fileName: String) -> Int {
		let map = Grid2D(fileName: fileName)
		let trailheads = map.allPositions.filter {
			map.value($0) == "0"
		}
		let total = trailheads.reduce(0) { total, pos in
			var peaks = Set<Position2D>()
			let trailScore = score(map: map, pos: pos, trail: [pos], peaks: &peaks)
			print("Trailhead \(pos.displayString): \(trailScore)")
			return total + trailScore
		}
		print("Total: \(total)")
		return total
	}

	func solveB(_ fileName: String) -> Int {
		fileName.count
	}
}
