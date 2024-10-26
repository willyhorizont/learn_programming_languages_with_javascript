class TreeNode:
    def __init__(self, value):
        self.value = value
        self.children = []

    def add_child(self, child_node):
        self.children.append(child_node)


class Tree:
    def __init__(self, root_value):
        self.root = TreeNode(root_value)

    def add(self, parent_value, child_value):
        # Find the parent node and add a child
        parent_node = self.find(self.root, parent_value)
        if (parent_node is None):
            print(f"Parent node {parent_value} not found.")
            return
        parent_node.add_child(TreeNode(child_value))

    def find(self, node, value):
        # Check if the current node is the one we are looking for
        if node.value == value:
            return node
        # Recursively search in the children
        for child in node.children:
            found_node = self.find(child, value)
            if (found_node is not None):
                return found_node
        return None

    def display(self, node=None, level=0):
        # If no node is provided, start from the root
        if (node is None):
            node = self.root
        print(" " * level * 4 + f"- {node.value}")
        for child in node.children:
            self.display(child, level + 1)

# Example usage:
tree = Tree("Root")
tree.add("Root", "Child 1")
tree.add("Root", "Child 2")
tree.add("Child 1", "Grandchild 1")
tree.add("Child 1", "Grandchild 2")
tree.add("Child 2", "Grandchild 3")

tree.display()
# Output:
# - Root
#     - Child 1
#         - Grandchild 1
#         - Grandchild 2
#     - Child 2
#         - Grandchild 3
