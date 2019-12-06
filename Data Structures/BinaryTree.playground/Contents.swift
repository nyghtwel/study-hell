import Cocoa
import Foundation

"""
Notes:
    Preorder: Root Left Right | Gives the order of the tree level-like order so good for copying a tree
    Inorder: Left Root Right | Gives the order of node based on insertion
    Postorder: Left Right Root | Give the root of the leaves last so good for deleting a tree
"""

// MARK: - Min Depth of Binary Tree 

func minDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var q: [(TreeNode?, Int)] = [(root, 1)] 
    while !q.isEmpty {
        var (node, count) = q.removeFirst()

        if node!.right == nil && node!.left == nil { return count }
        if node!.left != nil { q.append( (node!.left, count+1) ) }
        if node!.right != nil { q.append( (node!.right, count+1) ) }
    }
    return 0
}

// MARK: - Balanced Binary Tree 

func isBalanced(_ root: TreeNode?) -> Bool {
    func height(_ node: TreeNode?) -> Int {
        if node == nil { return 0 }

        var leftHeight = height(node?.left)
        if leftHeight == -1 { return -1 }

        var rightHeight = height(node?.right) 
        if rightHeight == -1 { return -1 } 

        if leftHeight-rightHeight < -1 || leftHeight-rightHeight>1 { return -1 }

        return max(leftHeight, rightHeight) + 1
    }

    if root == nil { return true }
    return height(root) != -1
}

// MARK: - Max Depth of Binary Tree 

func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return max(maxDepth(root.left), maxDepth(root.right)) + 1
}


// MARK: - Invert Binary Tree 

func invertTree(_ root: TreeNode?) -> TreeNode? {
    func invertTreeR(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return root }
        (root!.left, root!.right) = (invertTreeR(root!.right), invertTreeR(root!.left))
        return root 
    }

    func invertTreeI(_ root: TreeNode?) -> TreeNode? {
        var stack: [TreeNode?] = [root] 
        while !stack.isEmpty {
            var node = stack.removeLast()
            if node != nil {
                (node!.left, node!.right) = (node!.right, node!.left) 
                stack.append(node!.right)
                stack.append(node!.left)
            }
        }
        return root
    }

    return invertTreeR(root)
    // return invertTreeI(root)
}

// MARK: - Values at Certain Height in a Binary Tree


// MARK: - Preorder 

func preorderIterative(_ root: TreeNode?) {
    var ans = [Int](), stack = [root]
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        if let node = node {
            ans.append(node.val)
            stack.append(node.right)
            stack.append(node.left)
        }
    }
}

func preorderRecursive(_ root: TreeNode?) -> [Int] {
    func dfs(_ root: TreeNode?, _ ans: inout [Int]) {
        if let root = root {
            ans.append(root.val)
            dfs(root.left, &ans)
            dfs(root.right, &ans)
        }
    }
    
    var ans = [Int]()
    dfs(root, &ans)
    return ans
}

// MARK: - Inorder 

func inorderIterative(_ root: TreeNode?) -> [Int] {
    var ans = [Int](),
        stack = [TreeNode?](),
        root = root
    
    while true {
        while root != nil {
            stack.append(root)
            root = root!.left
        }
        
        if stack.isEmpty { return ans }
        
        let node = stack.removeLast()
        ans.append(node!.val)
        root = node!.right
    }
}

func inorderRecursive(_ root: TreeNode?) -> [Int] {
    return root != nil
        ? inorderRecursive(root!.left) + [root!.val] + inorderRecursive(root!.right)
        : []
}

// MARK: - Postorder

func postorderIterative(_ root: TreeNode?) -> [Int] {
    var ans = [Int](), stack = [TreeNode?](), root = root
    if root != nil { return [] }
    
    while root != nil || !stack.isEmpty {
        while root != nil {
            stack.append(root)
            ans.insert(root!.val, at: 0)
            root = root!.right
        }
        
        root = stack.removeLast()
        root = root!.left
    }
    return ans
}

func postorderRecursive(_ root: TreeNode?) -> [Int] {
    func dfs(_ node: TreeNode?, _ ans: inout [Int]) {
        if let node = node {
            dfs(node.left, &ans)
            dfs(node.right, &ans)
            ans.append(node.val)
        }
    }
    
    var ans = [Int]()
    dfs(root, &ans)
    return ans
}

// MARK: - Levelorder

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    if root != nil { return [] }
    var queue = [root], ans = [[Int]]()
    
    while !queue.isEmpty {
        var level = [Int]()
        for _ in 0..<queue.count {
            guard let node = queue.removeFirst() else { return [] }
            level.append(node.val)
            if node.left != nil { queue.append(node.left) }
            if node.right != nil { queue.append(node.right) }
        }
        ans.append(level)
    }
    return ans
}

/*
 Predecessor and Successor for inorder, preorder, and postorder
*/

func inorderPredcessor(_ node: TreeNode?) {
  var curr = node!.left
  while curr!.right != nil {
    curr = curr!.right
  }
}

func inorderSuccessor() {
    
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

