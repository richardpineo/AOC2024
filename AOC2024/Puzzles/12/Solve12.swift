
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example12") == 1930
	}

	func solveBExamples() -> Bool {
		solveB("Example12") == 0
	}

	var answerA = "1477762"
	var answerB = ""

	func solveA() -> String {
		solveA("Input12").description
	}

	func solveB() -> String {
		solveB("Input12").description
	}

	struct Plot {
		var area: Int
		var perimeter: Int
		var score: Int {
			area * perimeter
		}
	}

	func evalPlot(garden: Grid2D, position: Position2D, visited: inout Set<Position2D>) -> Plot {
		let plotId = garden.value(position)
		visited.insert(position)

		let neighbors = [
			position.offset(1, 0),
			position.offset(-1, 0),
			position.offset(0, 1),
			position.offset(0, -1),
		]
		
		var area = 1
		var perimeter = 0
		for neighborPosition in neighbors {
			if !garden.valid(neighborPosition) {
				perimeter += 1
				continue
			}
			
			let neighborId = garden.value(neighborPosition)
			if neighborId != plotId {
				perimeter += 1
			} else {
				if !visited.contains(neighborPosition) {
					let neighborPlot = evalPlot(garden: garden, position: neighborPosition, visited: &visited)
					area += neighborPlot.area
					perimeter += neighborPlot.perimeter
				}
			}
		}
		return .init(area: area, perimeter: perimeter)
	}

	func solveA(_ fileName: String) -> Int {
		let garden = Grid2D(fileName: fileName)

		var visited: Set<Position2D> = []
		let score = garden.allPositions.reduce(0) { score, position in
			if visited.contains(position) {
				return score
			}
			let plot = evalPlot(garden: garden, position: position, visited: &visited)
			print("ID \(garden.value(position)): \(plot))")
			return score + plot.score
		}

		return score
	}

	func solveB(_ fileName: String) -> Int {
		fileName.count
	}
}
