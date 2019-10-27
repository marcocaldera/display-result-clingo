#script (python)

from __future__ import print_function
import clingo
import json

def to_json(symbol):
  s = {}
  if symbol.type == clingo.SymbolType.Number:
    s['value'] = symbol.number
  elif symbol.type == clingo.SymbolType.Function:
    s['name'] = symbol.name
    if symbol.arguments:
      s['args'] = [to_json(a) for a in symbol.arguments]
  else:
    assert False, 'unrecognised type ' + symbol.type
  return s

def on_model(m):
  # Just the shown terms; see https://potassco.org/clingo/python-api/current/clingo.html#Model
  symbols = m.symbols(False, False, True, False, False, False)
  print(json.dumps([to_json(s) for s in symbols]))

def main(prg):
  prg.ground([("base",[])])
  # https://sourceforge.net/p/potassco/mailman/message/35495025/
  # https://github.com/potassco/clingo/tree/master/examples/clingo/enum-assumption
  prg.use_enumeration_assumption = False
  prg.solve(on_model=on_model)

#end.