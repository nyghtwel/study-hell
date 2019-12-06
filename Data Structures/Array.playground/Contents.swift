import Foundation

// 3 Sum
func threeSum(_ nums: [Int]) -> [[Int]] {
	var res: [[Int]] = []
	let nums: [Int] = nums.sorted()
	
	for i in 0..<nums.count {
		if i>0, nums[i] == nums[i-1] { continue }
		
		var left: Int = i+1, right: Int = nums.count-1
		while left<right {
			let sum: Int = nums[i] + nums[left] + nums[right]
			
			switch sum {
			case Int.min..<0:	left += 1
			case 1..<Int.max: 	right -= 1
			default:
				res.append([nums[i], nums[left], nums[right]])
				while left<right, nums[left] == nums[left+1] { left += 1 }
				while left<right, nums[right] == nums[right-1] { right -= 1 }
				left += 1
				right -= 1
			}
		}
	}
	return res
}
