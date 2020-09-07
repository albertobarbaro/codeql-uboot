/**
* @kind path-problem
*/

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
 
class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
      
      exists(MacroInvocation invocation |
          invocation.getMacro().getName().regexpMatch("ntoh(s|l|ll)")
          and invocation.getExpr() = this
      )
      
    } 
  
  }
 
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }

  override predicate isSink(DataFlow::Node sink) {
    // TODO
    exists(FunctionCall fc |
        fc.getTarget().getName() = "memcpy" and
        fc.getArgument(2) = sink.asExpr() and
        not fc.getArgument(2).isConstant()
    )

  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"