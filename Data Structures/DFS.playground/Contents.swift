import Foundation

/*
 DFS Problems

 Fundamentals: Subsets, Permutaions, Combination Sum
 -- Permutation (order matters), Combination (order doesn't matter)
 */

/*
 Input: [1,2,3]
 Output:
 [
     [3],
     [1],
     [2],
     [1,2,3],
     [1,3],
     [2,3],
     [1,2],
     []
 ]
 */

func subsets(_ nums: [Int]) -> [[Int]] {
  func dfs(_ ans: inout [[Int]], _ path: [Int], _ nums: [Int], _ start: Int) {
    ans.append(path)
    (start..<nums.count).forEach { dfs(&ans, path+[nums[$0]], nums, $0+1) }
  }

  var ans = [[Int]]()
  dfs(&ans, [], nums.sorted(), 0)
  return ans
}

// Same as subsets but input can have duplicates and soln must not contain duplicate subsets
func subsetsII(_ nums: [Int]) -> [[Int]] {
  func _dfs(_ ans: inout [[Int]], _ path: [Int], _ nums: [Int], _ start: Int) {
    ans.append(path)
    (start..<nums.count).filter { !($0>start && nums[$0]==nums[$0-1]) }
      .forEach { _dfs(&ans, path+[nums[$0]], nums, $0+1)}
//    for i in start..<nums.count {
//      if i>start, nums[i] == nums[i-1] { continue }
//      _dfs(&ans, path+[nums[i]], nums, i+1)
//    }
  }

  var ans = [[Int]]()
  _dfs(&ans, [], nums.sorted(), 0)
  return ans
}

/*
 Input:[1,2,3]
 Output:
 [
     [1,2,3],
     [1,3,2],
     [2,1,3],
     [2,3,1],
     [3,1,2],
     [3,2,1]
 ]
 ** permute with duplicates??
 */
func permute(_ nums: [Int]) -> [[Int]] {
  func _dfs(_ ans: inout [[Int]], _ path: [Int]) {
    if path.count == nums.count {
      ans.append(path)
      return
    }
    nums.filter { !path.contains($0) }
      .forEach { _dfs(&ans, path+[$0]) }
  }

  var ans = [[Int]]()
  _dfs(&ans, [])
  return ans
}

/*
 Combination Sum VERY important. Frequently shows up in interviews
 Ex: Find a combination of nums that equal to target
 */
func combinationSum(_ nums: [Int], _ target: Int) -> [[Int]] {
  func _dfs(_ ans: inout [[Int]], _ path: [Int], _ nums: [Int], _ target: Int, _ start: Int) {
    if target == 0 { ans.append(path); return }

    (start..<nums.count).filter { nums[$0] <= target }
      .forEach { _dfs(&ans, path+[nums[$0]], nums, target-nums[$0], $0)}

//    for i in start..<nums.count {
//      if nums[i] > target { break }
//      _dfs(&ans, path+[nums[i]], nums, target-nums[i], i)
//    }
  }

  var ans = [[Int]]()
  _dfs(&ans, [], nums.sorted(), target, 0)
  return ans
}

/*
 Combination Sum but with duplicates
 Ex: Find a combination of nums that can have duplicates to equal target
 */
func combinationSumII(_ nums: [Int], _ target: Int) -> [[Int]] {
  func _dfs(_ ans: inout [[Int]], _ path: [Int], _ nums: [Int], _ target: Int, _ start: Int) {
    if target == 0 { ans.append(path); return }

    (start..<nums.count).filter { nums[$0] <= target } // filters valid candidates
      .filter { !($0>start && nums[$0] != nums[$0-1]) } // filters duplicates
      .forEach { _dfs(&ans, path+[nums[$0]], nums, target-nums[$0], $0+1) } // performs dfs
  }

  var ans = [[Int]]()
  _dfs(&ans, [], nums.sorted(), target, 0)
  return ans
}

var str = "Hello, playground"

var start = [1,2,2]

//subsetsII(start)

combinationSum([2,3,6,7], 7)
combinationSumII([2,5,2,1,2], 5)
