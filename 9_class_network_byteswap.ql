import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    
    exists(MacroInvocation mi |
        mi.getMacroName() = "ntohs" or
        mi.getMacroName() = "ntohl" or
        mi.getMacroName() = "ntohll" and
        mi.getExpr() = this
    )
    
  } 

}

from NetworkByteSwap n
select n