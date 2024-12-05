
import AOCLib
import Foundation

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example5") == 143
	}

	func solveBExamples() -> Bool {
		solveB("Example5") == 0
	}

	var answerA = "4924"
	var answerB = ""

	struct Ordering {
		var first: Int
		var second: Int
	}
	
	class Job {
		var orderings: [Ordering] = []
		var pages: [[Int]] = []
	}
	
	func load(_ fileName: String) -> Job {
		let lines = FileHelper.load(fileName)!
		let pageBreak = lines.firstIndex { $0.isEmpty }!
		let job: Job = .init()
		for index in 0 ..< pageBreak {
			let ordering = lines[index].split(separator: "|")
			job.orderings.append(.init(first: Int(ordering[0])!, second: Int(ordering[1])!))
		}
		for index in (pageBreak+1) ..< lines.count {
			let pages = lines[index].split(separator: ",")
			job.pages.append(pages.map { Int($0)! } )
		}
		return job
	}
	
	func solveA() -> String {
		solveA("Input5").description
	}

	func solveB() -> String {
		solveB("Input5").description
	}
	
	func passes(_ orderings: [Ordering], _ pages: [Int]) -> Bool {
		for index in 0 ..< pages.count {
			let applicable = orderings.filter { $0.second == pages[index] }
			for check in (index + 1) ..< pages.count {

				if applicable.contains(where: { $0.first == pages[check] }) {
					return false
				}
			}
		}
		return true
	}
	
	func middlePage(pages: [Int]) -> Int {
		pages[pages.count/2]
	}
	
	func solveA(_ fileName: String) -> Int {
		let job = load(fileName)
		return job.pages.reduce(0) { count, pages in
			if !passes(job.orderings, pages) {
				return count
			}
			return count + middlePage(pages: pages)
		}
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
