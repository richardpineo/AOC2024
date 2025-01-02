
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example11", numBlinks: 6) == 22 &&
		solve("Example11", numBlinks: 25) == 55312
	}

	func solveBExamples() -> Bool {
		// No examples
		true
	}

	var answerA = "186203"
	var answerB = ""

	func solveA() -> String {
		solve("Input11", numBlinks: 25).description
	}

	func solveB() -> String {
		solve("Input11", numBlinks: 75).description
	}
	
	func blink(stones: inout Array<Int>) {
		var index = 0
		while index < stones.count {
			let current = stones[index]
			if current == 0 {
				stones[index] = 1
			} else {
				let length = current.description.count
				if length % 2  == 0 {
					// even
					let first = Int(current.description.subString(start: 0, count: length/2))!
					let second = Int(current.description.subString(start: length/2, count: length/2))!
					stones[index] = first
					stones.insert(second, at: index+1)
					index += 1
				} else {
					stones[index] = current * 2024
				}
			}
			
			index += 1
		}
		print("BLINK: now there are \(stones.count)")
	}
	
	func solve(_ fileName: String, numBlinks: Int) -> Int {
		var stones: Array<Int> = FileHelper.loadAndTokenize(fileName)[0].map { Int($0)! }
		print("Starting \(numBlinks): " + stones.debugDescription)
		for _ in 0 ..< numBlinks {
			blink(stones: &stones)
		}
		print("After \(numBlinks) blinks: \(stones.count)")
		return stones.count
	}
}
