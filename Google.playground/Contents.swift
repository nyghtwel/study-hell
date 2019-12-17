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
	Watering Flowers
*/

func wateringFlowers(_ plants: [Int], _ capacity1: Int, _ capacity2: Int) -> Int {
	var pos1 = 0 , pos2 = plants.count - 1
	var water1 = 0, water2 = 0
	var refills = 0
	
	while pos1 <= pos2 {
		if pos1 == pos2 {
			if water1 + water2 < plants[pos1] {
				refills += 1;
				break
			}
			break
		}
		
		if water1 < plants[pos1] {
			refills += 1
			water1 = capacity1
		}
		
		water1 -= plants[pos1]
		
		if water2 < plants[pos2] {
			refills += 1
			water2 = capacity2
		}
		
		water2 -= plants[pos2]
		
		pos1 += 1
		pos2 -= 1
	}
	
	return refills
}

/**
	Min Domino Rotations For Equal Row: New Grad

	Note: Only need to check first element in each row because that is the only possbile soln, otherwise it is not possible and return -1.
*/
func minDominoRotations(_ A: [Int], _ B: [Int]) -> Int {
	func minRotations(_ target: Int) -> Int {
		var up = 0, down = 0
		
		for i in 0..<A.count {
			if A[i] != target && B[i] != target { return -1 }
			if A[i] != target { up += 1 }
			if B[i] != target { down += 1 }
		}
		
		return min(down, up)
	}
	
	let up = minRotations(A[0]), down = minRotations(B[0])
	
	if up == -1 || down == -1 { return max(up, down) }
	return min(up, down)
}

/**
	Time to Type a String
	- Special keyboard with all keys in a single row.
	- time to move finger from i to index j is abs( j - 1 )
	- Given a string `keyboard` that describes the keyboard layout and string text, return an int for time to type string `text`

	- Input: keyboard = "abcdefghijklmnopqrstuvwxy", text = "cba", Output: 4
*/
func timeToType(_ keyboard: String, _ text: String) -> Int {
	var ans = 0, curr = 0
	let map = Dictionary(uniqueKeysWithValues: zip(keyboard, 0..<keyboard.count))
	
	for char in text {
		let diff = abs(map[char]! - curr)
		ans += diff
		curr = map[char]!
	}
	
	return ans
}

timeToType("abcdefghijklmnopqrstuvwxy", "cba")

class TreeNode {
	var val: Int
	var left: TreeNode?
	var right: TreeNode?
	init(_ val: Int) {
		self.val = val
		self.left = nil
		self.right = nil
	}
}
/**
	Maximum Level Sum of a Binary Tree
*/
func maxLevelSumBFS(_ root: TreeNode?) -> Int {
	if root == nil { return 0 }
	var currentLevel: [TreeNode] = [root!]
	var maxLevel = 0, levelCount = 0, maxSum = Int.min
	
	while !currentLevel.isEmpty {
		levelCount += 1
		var nextLevel = [TreeNode]()
		var currentSum = 0
		
		for node in currentLevel {
			currentSum += node.val
			
			if node.left != nil { nextLevel.append(node.left!) }
			if node.right != nil { nextLevel.append(node.right!) }
		}
		
		if maxSum < currentSum {
			maxSum = currentSum
			maxLevel = levelCount
		}
		currentLevel = nextLevel
	}
	return maxLevel
}

func maxLevelSumDFS(_ root: TreeNode?) -> Int {
	var levelSum: [Int:Int] = [:]
	func dfs(_ node: TreeNode?, _ level: Int) {
		if node == nil { return }
		if levelSum[level] == nil { levelSum[level] = 0 }
		
		levelSum[level]! += node!.val
		dfs(node!.left, level+1)
		dfs(node!.right, level+1)
	}
	// 1 since root == 1
	dfs(root, 1)
	let max = levelSum.values.max()!
	levelSum = Dictionary(uniqueKeysWithValues: zip(levelSum.values, levelSum.keys))
	return levelSum[max]!
}

/**
	Min Number of Chairs
	`n` guests who are invited to a part. The `k-th` guest will attent the party at time `S[k]` and leave the part at time `E[k]`.
	Return an int denoting the min num of chairs you need such that everyone attending the party can sit down.

	https://leetcode.com/problems/meeting-rooms-ii
*/
func minNumberOfChairs(_ S: [Int], _ E: [Int]) -> Int {
	var all: [[Int]] = S.map{ [$0, 1] } + E.map{ [$0, -1] }
	all.sort{ ($0[0] != $1[0]) ? $0[0] < $1[0] : $0[1] < $1[1] }
	
	var num = 0, largest = 0
	
	for time in all {
		let t = time[1]
		num += t
		largest = max(largest, num)
	}
	return largest
}
minNumberOfChairs([1,2,6,5,3], [5,5,7,6,8])

/**
	Min Meeting Rooms
*/
func minMeetingRooms(_ intervals: [[Int]]) -> Int {
//	 var starts = intervals.map { $0[0] }.sorted()
//	 var ends = intervals.map { $0[1] }.sorted()
//	 var count = 0, i = 0, j = 0, result = 0
//
//	 while i<starts.count, j<ends.count {
//		 if starts[i]<ends[j] {
//			 count += 1
//			 i += 1
//		 } else {
//			 count -= 1
//			 j += 1
//		 }
//		 result = max(result, count)
//	 }
//	 return result
	
	var alls: [[Int]] = intervals.reduce(into: []) {
		$0.append([$1[0], 1])
		$0.append([$1[1], -1])
	}

	alls.sort { ($0[0] != $1[0]) ? $0[0] < $1[0] : $0[1] < $1[1] }
	var num = 0, largest = 0
	
	for time in alls {
		let t = time[1]
		num += t
		largest = max(largest, num)
	}
	return largest
}

/**
	K Closest Points to Origin
*/
func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
	let ans = points.sorted { (point1, point2) in
		let point1Distance = point1[0]*point1[0] + point1[1]*point1[1]
		let point2Distance = point2[0]*point2[0] + point2[1]*point2[1]
		return point1Distance < point2Distance
	}
	return Array(ans.prefix(K))
}

// Note need to learn more string functions...
