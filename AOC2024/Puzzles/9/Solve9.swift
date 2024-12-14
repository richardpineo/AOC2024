
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 1928
	}

	func solveBExamples() -> Bool {
		solveB("Example9") == 2858
	}

	var answerA = "6430446922192"
	var answerB = "6460170593016"

	func solveA() -> String {
		solveA("Input9").description
	}

	func solveB() -> String {
		solveB("Input9").description
	}

	let spaceId: Int = -1

	func checksum(_ contents: [Int]) -> Int {
		var sum = 0
		for index in 0..<contents.count {
			if contents[index] != spaceId {
				sum += index * contents[index]
			}
		}
		return sum
	}
	
	func load(_ fileName: String) -> [Int] {
		let line = FileHelper.load(fileName)![0]
		if line.count % 2 != 1 {
			return []
		}
				
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
		
		return contents
	}
	
	func solveA(_ fileName: String) -> Int {
		var contents = load(fileName)
		
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
		var contents = load(fileName)
		
		var id = contents.max()!
		
		func findSpace(size: Int, maxIndex: Int) -> Int? {
			var index = 0
			while index < maxIndex {
				var spaceCount = 0
				var spaceIndex = index
				while contents[spaceIndex] == spaceId {
					spaceCount += 1
					spaceIndex += 1
					if spaceCount >= size {
						return index
					}
				}
				index = spaceIndex + 1
			}
			return nil
		}
		
		while id >= 1 {
			let size = contents.count { $0 == id }
			let idStart = contents.firstIndex(of: id)!
			
			if let spaceIndex = findSpace(size: size, maxIndex: idStart) {
				for count in 0 ..< size {
					contents[spaceIndex + count] = id
					contents[idStart + count] = spaceId
				}
			}
			
			id -= 1
		}
			
		return checksum(contents)
	}
}
