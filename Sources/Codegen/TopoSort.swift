// First Topological Sort in Apple's new language Swift
// Updated on 10/30/2016 to account for the newest version of Swift (3.0)
// Michael Recachinas
enum TopologicalSortError : Error {
  case CycleError(String)
}

/// Simple helper method to check if a graph is empty
/// - parameters:
///     - dependency_list: a `Dictionary<String, [String]>` containing the graph structure
/// - returns: a `Bool` that determines whether or not the values in a dictionary are empty
func isEmpty(graph: Dictionary<String, [String]>) -> Bool {
  for (_, value) in graph {
    if value.count > 0 {
      return false
    }
  }
  return true
}

/// Performs the topological sort
/// - parameters:
///     - dependency_list
/// - returns: a sorted `[String]` containing a possible topologically sorted path
/// - throws: a `TopologicalSortError.CycleError` if the graph is not empty (meaning there exists a cycle)
func topo_sort(dependency_list: Dictionary<String, [String]>) throws -> [String] {
  var sorted: [String] = []
  var next_depth: [String] = []
  var graph = dependency_list
  
  for key in graph.keys {
    if graph[key]! == [] {
      next_depth.append(key)
    }
  }
  
  for key in next_depth {
    graph.removeValue(forKey: key)
  }
  
  while next_depth.count != 0 {
    next_depth.sort(by: >)
    let node = next_depth.removeLast()
    sorted.append(node)
    
    for key in graph.keys {
      let arr = graph[key]
      let dl = arr!.filter({ $0 == node})
      if dl.count > 0 {
        graph[key] = graph[key]?.filter({$0 != node})
        if graph[key]?.count == 0 {
          next_depth.append(key)
        }
      }
    }
  }
  if !isEmpty(graph: graph) {
    throw TopologicalSortError.CycleError("This graph contains a cycle.")
  }
  else {
    return sorted
  }
}
