
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example6") == 41
	}

	func solveBExamples() -> Bool {
		solveB("Example6") == 0
	}

	var answerA = "5564"
	var answerB = ""

	func solveA() -> String {
		solveA("Input6").description
	}

	func solveB() -> String {
		solveB("Input6").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		var pos = grid.allPositions.first {
			grid.value($0) == "^"
		}!
		var heading: Heading = .north

		var visited: Set<Position2D> = .init()
		
		while grid.valid(pos) {
			let nextDelta: Position2D = switch heading {
			case .north: .init(0, -1)
			case .east: .init(1, 0)
			case .south: .init(0, 1)
			case .west: .init(-1, 0)
			}
			
			let newPos = pos + nextDelta
			if grid.safeValue(newPos) == "#" {
				heading = heading.rightwards
			} else {
				visited.insert(pos)
				pos = newPos
			}
		}

		return visited.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
