
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 1928
	}

	func solveBExamples() -> Bool {
		solveB("Example9") == 0
	}

	var answerA = "6430446922192"
	var answerB = ""

	func solveA() -> String {
		solveA("Input9").description
	}

	func solveB() -> String {
		solveB("Input9").description
	}

	func checksum(_ contents: [Int]) -> Int {
		var sum = 0
		for index in 0..<contents.count {
			sum += index * contents[index]
		}
		return sum
	}
	
	func solveA(_ fileName: String) -> Int {
		let line = FileHelper.load(fileName)![0]
		if line.count % 2 != 1 {
			return -666
		}
		
		let spaceId: Int = -1
		
		var contents: [Int] = []
		var id: Int = 0
		for index in stride(from: 0, to: line.count, by: 2) {
			let blockFile = Int(String(line.character(at:index)))!
			let file: [Int] = .init(repeating: id, count: blockFile)
			contents.append(contentsOf: file)
			id += 1
			
			if index + 1 < line.count {
				let blockSpace = Int(String(line.character(at:index + 1)))!
				let space: [Int] = .init(repeating: spaceId, count: blockSpace)
				contents.append(contentsOf: space)
			}
		}
		
		while contents.contains(spaceId) {
			let last = contents.popLast()!
			if last == spaceId {
				continue
			}
			let spaceIndex = contents.firstIndex(of: spaceId)!
			contents[spaceIndex] = last
		}

		return checksum(contents)
	}

	func solveB(_ fileName: String) -> Int {
		fileName.count
	}
}
