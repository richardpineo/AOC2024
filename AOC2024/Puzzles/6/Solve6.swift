
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example6") == 41
	}

	func solveBExamples() -> Bool {
		solveB("Example6") == 6
	}

	var answerA = "5564"
	var answerB = "1976"

	func solveA() -> String {
		solveA("Input6").description
	}

	func solveB() -> String {
		solveB("Input6").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		let result = traverse(grid: grid)
		if result.looped {
			return 0
		}
		var positions = Set<Position2D>()
		for bearing in result.visited {
			positions.insert(bearing.position)
		}
		return positions.count
	}
	
	func startingFrom(grid: Grid2D) -> Bearing {
		let startingPos = grid.allPositions.first {
			grid.value($0) == "^"
		}!
		return .init(position: startingPos, heading: .north)
	}

	struct Result {
		var looped: Bool
		var visited: [Bearing]
	}
	
	func traverse(grid: Grid2D) -> Result {
		var bearing: Bearing = startingFrom(grid: grid)
		
		var visited: Set<Bearing> = .init()
		while grid.valid(bearing.position) {
			if visited.contains(bearing) {
				return .init(looped: true, visited: Array(visited))
			}
			visited.insert(bearing)

			let newBearing = bearing.move()
			if grid.safeValue(newBearing.position) == "#" {
				bearing = .init(position: bearing.position, heading: bearing.heading.rightwards)
			} else {
				bearing = newBearing
			}
		}
		return .init(looped: false, visited: Array(visited))
	}
	
	func solveB(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		let bearing: Bearing = startingFrom(grid: grid)

		let traversed = traverse(grid: grid)
		
		let possibleObstructions = grid.allPositions.filter { possible in
			if possible == bearing.position {
				return false
			}
			if grid.value(possible) == "#" {
				return false
			}
			if !traversed.visited.contains(where: { $0.position == possible }) {
				return false
			}
			return true
		}

		let actual = possibleObstructions.filter {
			makesLoop(grid, $0)
		}
		return actual.count
	}
	
	private func makesLoop(_ grid: Grid2D, _ pos: Position2D) -> Bool {
		var loopCheck = grid.clone()
		loopCheck.setValue(pos, "#")
		let result = traverse(grid: loopCheck)
		return result.looped
	}
}
