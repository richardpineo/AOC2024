
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example6") == 41
	}

	func solveBExamples() -> Bool {
		solveB("Example6") == 0
	}

	var answerA = ""
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

		while grid.valid(pos) {
			let nextDelta: Position2D = switch heading {
			case .north: .init(0, -1)
			case .east: .init(1, 0)
			case .south: .init(0, 1)
			case .west: .init(-1, 0)
			}
			
			if grid.safeValue(pos.offset(nextDelta)) == "#" {
				
			}
		}

		return startingPos!.x
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
