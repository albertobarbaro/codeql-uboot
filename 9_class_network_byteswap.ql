import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    
    exists(MacroInvocation invocation |
        invocation.getMacro().getName().regexpMatch("ntoh(s|l|ll)")
        and invocation.getExpr() = this)
    
  } 

}

from NetworkByteSwap n
select n