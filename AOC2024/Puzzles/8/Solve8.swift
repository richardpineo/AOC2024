
import Algorithms
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 14
	}

	func solveBExamples() -> Bool {
		solveB("Example8easy") == 9 &&
			solveB("Example8") == 34
	}

	var answerA = "249"
	var answerB = "905"

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		solveB("Input8").description
	}

	func findAntennas(_ grid: Grid2D) -> [Character: [Position2D]] {
		var antennas: [Character: [Position2D]] = [:]

		for position in grid.allPositions {
			let v = grid.value(position)
			if v == "." || v == "#" {
				continue
			}
			var antennaPositions = antennas[v] ?? []
			antennaPositions.append(position)
			antennas[v] = antennaPositions
		}

		return antennas
	}

	func solveA(_ fileName: String) -> Int {
		let grid: Grid2D = .init(fileName: fileName)
		let antennas = findAntennas(grid)

		var antinodes: Set<Position2D> = .init()

		for antenna in antennas {
			for pair in antenna.value.combinations(ofCount: 2) {
				let dx = pair[0].x - pair[1].x
				let dy = pair[0].y - pair[1].y

				antinodes.insert(.init(pair[0].x + dx, pair[0].y + dy))
				antinodes.insert(.init(pair[1].x - dx, pair[1].y - dy))
			}
		}

		let validAntinodes = antinodes.filter { grid.valid($0) }
		return validAntinodes.count
	}

	func solveB(_ fileName: String) -> Int {
		let grid: Grid2D = .init(fileName: fileName)
		let antennas = findAntennas(grid)

		var antinodes: Set<Position2D> = .init()

		for antenna in antennas {
			for pair in antenna.value.combinations(ofCount: 2) {
				let oneSlope = MathHelper.reducedSlope(pair[0], pair[1])
				let anotherSlope: Position2D = .init(-oneSlope.x, -oneSlope.y)

				let master = pair[0]
				antinodes.insert(master)
				var oneWay = master
				var orAnother = master
				var done = false
				while !done {
					oneWay = oneWay.offset(oneSlope)
					orAnother = orAnother.offset(anotherSlope)
					done = true
					if grid.valid(oneWay) {
						antinodes.insert(oneWay)
						done = false
					}
					if grid.valid(orAnother) {
						antinodes.insert(orAnother)
						done = false
					}
				}
			}
		}

		let antinodeGrid = Grid2D(positions: Array(antinodes), value: "#", repeating: ".")
		// print(grid.debugDisplay)
		// print(antinodeGrid.debugDisplay)
		return antinodes.count
	}
}
