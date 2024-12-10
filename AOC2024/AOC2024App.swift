
import AOCLib
import SwiftUI

@main
struct AOC2024App: App {
	let puzzles = Puzzles2024()

	var body: some Scene {
		WindowGroup {
			MainView(repo: puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles.puzzles))
		}
	}
}
