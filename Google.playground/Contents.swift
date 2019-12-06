import Foundation

//https://leetcode.com/discuss/interview-question/352460/Google-Online-Assessment-Questions

// MARK: - Compare String
/**
Intern level
One string is strictly smaller than another when the freq. of occur. of the smallest char
in the string is less than the freq. of occur. of the smallest char. in the comparison
string.

A = "abcd,aabc,dc"
B = "aaa,aa"
returns [3, 2]
*/
func compareString(_ A: String, _ B: String) -> [Int] {
	let wordsA = A.components(separatedBy: ",")
//	let wordsA = A.split(separator: ",") // this returns [String.Subsequence] instead of [String]
	let wordsB = B.components(separatedBy: ",")
	var ans = [Int]()

//	var freqCounter = Array(repeating: 0, count: 11)
//
//	for word in wordsA {
//		let minFreq = word.filter{ $0 == word.min() }.count
//		freqCounter[minFreq] += 1
//	}
//
//
//	for word in wordsB {
//		let minFreq = word.filter{ $0 == word.min() }.count
//		ans.append(freqCounter[..<minFreq].reduce(0, +))
//	}

	for b in wordsB {
		var count = 0
		let minBCount = b.filter{$0 == b.min()}.count
		for a in wordsA {
			let minACount = a.filter{ $0 == a.min() }.count
			if minBCount > minACount { count += 1 }
		}
		ans.append(count)
	}
	return ans
}
compareString("abcd,aabc,bd", "aaa,aa")

/**
	Largest Subarray Length K: Intern
*/
func largestSubArray(_ a: [Int], k: Int) -> [Int] {
	var firstIndex = 0
	for index in 0...a.count-k {
		if a[firstIndex] < a[index] {
			firstIndex = index
		}
	}
	return Array(a[firstIndex..<firstIndex+k])
}
largestSubArray([1,4,3,2,5], k: 4)

/**
	Maximum Time: Intern

	Time is hh:mm some digits are missing by the char ?. Replace the missing char so the time is the maximum possible
*/
func maxTime(_ time: String) -> String {
	var time = Array(time)
	// max can be 23
	if time[0] == "?" {
		time[0] = (time[1] == "?" || time[1] <= "3") ? "2" : "1"
	}
	// max is 23 or 19 or 09
	if time[1] == "?" {
		time[1] = (time[0] == "2") ? "3" : "9"
	}
	// max is 59
	time[3] = (time[3] == "?") ? "5" : time[3]
	time[4] = (time[4] == "?") ? "9" : time[4]
	return String(time)
}
maxTime("23:5?")
maxTime("2?:??")
maxTime("1?:??")

/**
	Most Booked Hotel Room: Intern
*/

