import Foundation

// Letter Combinations of a Phone Number
func letterCombinations(_ digits: String) -> [String] {
	guard !digits.isEmpty else { return [] }
	
	let phone: [Character: String] = [
		"2": "abc",
		"3": "def",
		"4": "ghi",
		"5": "jkl",
		"6": "mno",
		"7": "pqrs",
		"8": "tuv",
		"9": "wxyz"]
	
	var combinations: [String] = []
	var strings: [String] = digits.compactMap { phone[$0] }
	
	func letterCombinations(
		_ index: Int,
		_ strings: [String],
		_ carry: String
	) {
		guard index < strings.count else { combinations.append(carry); return }
		
		strings[index].forEach { letterCombinations(index+1, strings, carry+String($0)) }
	}
	
	letterCombinations(0, strings, "")
	return combinations
}
