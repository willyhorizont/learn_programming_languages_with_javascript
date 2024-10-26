class DirectedGraph:
    def __init__(self):
        # Dictionary to store the adjacency list
        self.graph = {}

    def add_node(self, node):
        # Add a new node (vertex) to the graph (only if it doesn't already exist)
        if node not in self.graph:
            self.graph[node] = []

    def add_edge(self, origin_node, destination_node):
        # Add a directed edge (origin_node -> destination_node)
        if origin_node not in self.graph:
            self.add_node(origin_node)
        if destination_node not in self.graph:
            self.add_node(destination_node)
        self.graph[origin_node].append(destination_node)

    def has_edge(self, origin_node, destination_node):
        # Check if there is an edge from origin_node to destination_node
        if origin_node in self.graph:
            return destination_node in self.graph[origin_node]
        return False

    def get_neighbors(self, node):
        # Return the neighbors (outgoing edges) of a node
        return self.graph.get(node, [])

    def display(self):
        # Print out the graph (adjacency list)
        for node, neighbors in self.graph.items():
            print(f"{node} -> {neighbors}")

# Example usage:
graph = DirectedGraph()
graph.add_edge("A", "B")
graph.add_edge("A", "C")
graph.add_edge("B", "D")
graph.add_edge("C", "D")

graph.display()
# Output:
# A -> ['B', 'C']
# B -> ['D']
# C -> ['D']
# D -> []
