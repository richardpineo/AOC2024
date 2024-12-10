
import AOCLib
import Foundation
import Algorithms

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 14
	}

	func solveBExamples() -> Bool {
		solveB("Example8") == 0
	}

	var answerA = "249"
	var answerB = ""

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		solveB("Input8").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		
		var antennas: [Character: [Position2D]] = [:]
		
		grid.allPositions.forEach { position in
			let v = grid.value(position)
			if v == "." || v == "#" {
				return
			}
			var antennaPositions = antennas[v] ?? []
			antennaPositions.append(position)
			antennas[v] = antennaPositions
		}
		
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
		0
	}
}
