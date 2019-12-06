import Foundation

// Find the length of the longest substring w/o repeating chars
func lengthOfLongestSubstring(_ s: String) -> Int {
    var dict: [Character: Int] = [:]
    var offset: Int = -1, longest: Int = 0
    
    for (i, char) in s.enumerated() {
        if let pos = dict[char], offset < pos {
            offset = pos
        }
        dict[char] = i
        longest = max(longest, i-offset)
    }
    return longest
}

// Longest palindrome
func longestPalindrome(_ s: String) -> String {
    let s: [Character] = Array(s)
    var result: [Character] = []
    var i: Int = 0
    
    while i < s.count - (result.count/2) {
        var left: Int = i, right: Int = i
        
        while right+1 < s.count && s[right] == s[right+1] {
            right += 1
        }
        
        i = right+1
        while 0<left && right<s.count-1 && s[left-1] == s[right+1] {
            left -= 1
            right += 1
        }
        
        let length: Int = right-left+1
        if length>result.count {
            result = Array(s[left...right])
        }
    }
    return String(result)
}

var array: [(Int, Int)] = [(1,2)]
var (temp, temp2) = array.removeLast()
temp
temp2
