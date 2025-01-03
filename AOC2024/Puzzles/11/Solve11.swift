
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
	var answerB = "221291560078593"

	func solveA() -> String {
		solve("Input11", numBlinks: 25).description
	}

	func solveB() -> String {
		solve("Input11", numBlinks: 75).description
	}
	
	struct MemoizedBlink {
		let first: Int
		let second: Int?
	}
	var memoized: [Int: MemoizedBlink] = [:]
	
	struct Key: Hashable {
		let stone: Int
		let depth: Int
	}
	var cache: [Key: Int] = [:]
	
	func parse(stone: Int) -> MemoizedBlink {
		if let found =  memoized[stone] {
			return found
		}
		let length =  Int(floor(log10(CGFloat(stone)))+1)
		if length % 2 == 0 {
			// even
			let base = Int(pow(10, Double(length/2)))
			let memo: MemoizedBlink =  .init(first: stone / base, second: stone % base)
			memoized[stone] = memo
			return memo
		}
		let memo: MemoizedBlink =  .init(first: stone * 2024, second: nil)
		memoized[stone] = memo
		return memo
	}
	
	func blink(stone: Int?, depth: Int) -> Int {
		guard let stone else {
			return 0
		}
		if depth == 0 {
			return 1
		}
		if stone == 0 {
			return blink(stone: 1, depth: depth - 1)
		}
		
		let key: Key = .init(stone: stone, depth: depth)
		if let found = cache[key] {
			return found
		}
	
		let blinked = parse(stone: stone)
		let val = blink(stone: blinked.first, depth: depth - 1) +
			blink(stone: blinked.second, depth: depth - 1)
		cache[key] = val
		return val
	}

	func solve(_ fileName: String, numBlinks: Int) -> Int {
		let stones = FileHelper.loadAndTokenize(fileName)[0].map { Int($0)! }
		let count = stones.reduce(0) {
			$0 + blink(stone: $1, depth: numBlinks)
		}
		return count
	}
}
