from antlr4 import *
from java9Lexer import java9Lexer
from java9Listener import java9Listener
from java9Parser import java9Parser
import argparse
import subprocess
# from HelloLexer import HelloLexer
# from HelloListener import HelloListener
# from HelloParser import HelloParser
# from HelloVisitor import HelloVisitor
import sys

class HelloPrintListener(java9Listener):
    def __init__(self,rule_map):
        self.l = []
        self.indent  = 0
        self.rule_map = rule_map
        self.depth = 0
        self.file = open('tree.txt','w')
  
    def format(self,s):
        escape = ['"',"'"]
        for c in escape:
            x = r'\%s'%(c)
            s = s.replace(c,x)
        return s
    def enterCompilationUnit(self, ctx):
        
        self.file.write('[$#$#')
        self.file.write(self.format(self.rule_map[ctx.getRuleIndex()])+'$#$#')
        # self.file.write((ctx).getPayload(),ctx.getRuleIndex())
        # self.file.write([f for f in dir(type(ctx)) if not f.startswith('_')])
        self.visit(ctx)
        self.file.write(']$#$#')

        # self.file.write(']'+'')
    # def EnterEveryRule(self,ctx):
    #     self.file.write(ctx.getText())
    def visit(self,ctx):
        self.depth+=1
        num = ctx.getChildCount()
        # self.file.write(self.depth)
        
            # self.file.write(ctx.getPayload(),ctx.getChildCount(),ctx.getRuleIndex())
        if num != 0:
            rule_index = ctx.getRuleIndex()
            num = ctx.getChildCount()
            if num != 1 or ctx.getChild(0).getChildCount()==0:
                
                self.file.write('['+'$#$#')
                self.file.write(self.format(self.rule_map[rule_index])+'$#$#')
                # self.file.write()

            for i in range(num):
                self.visit(ctx.getChild(i))
            
            if num != 1 or ctx.getChild(0).getChildCount()==0:  
                self.file.write(']'+'$#$#')
                # self.file.write()

            self.depth-=1
                # self.file.write(']'+'$#$#')

        else:
            # self.file.write(ctx.getParent().getRuleIndex())
            # self.file.write('Index',type(ctx),ctx.getChildCount(),ctx.getRuleIndex(),e)
            text = ctx.getText()
            # self.file.write()
            # self.file.write('#### text',text,' ####')
            if text.strip()!="":
                self.file.write('['+'$#$#')
                if text == '[':
                    self.file.write('bracket_['+'$#$#')
                elif text == ']':
                    self.file.write('braket_]'+'$#$#') 
                else:
                    self.file.write(self.format(text)+'$#$#')
                self.file.write(']'+'$#$#')

            self.depth-=1

    # def enterClassDeclaration(self,ctx):
    #     self.file.write('1234')
        # self.file.write("Hello: %s" % ctx.public())
args = None
log = None
def main():
    global args
    global log
    parser = argparse.ArgumentParser(description='Create a syntax tree for a java program.')
    parser.add_argument('--verbose','-v',action='count',default=0,
                        help='Display intermediate steps before outputing the parse tree')
    parser.add_argument('-input', 
                        help='input file name from which the program must be fetched')
    parser.add_argument('-out', 
                        help='output file name to which the postscript is written',default='syntax_tree.ps')

    args = parser.parse_args()
    # print(args)
    if not args.input:
        print('ERROR: enter input file name')
        exit(0)
    if args.out == 'syntax_tree.ps' and args.verbose == 1:    
        print('WARNING: output file not  entered (defaults to syntax_tree.ps)')
    rule_map = {}
    for line in open('rules').read().split('\n'):
        if(line.strip()!=""):
            rule_head = line.split(' ')[0]
            rule_index = int(line.split(' ')[1])
            rule_map[rule_index] = rule_head
    lexer = java9Lexer(FileStream(args.input))
    stream = CommonTokenStream(lexer)
    parser = java9Parser(stream)
    tree = parser.compilationUnit()
    printer = HelloPrintListener(rule_map)
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
if __name__ == '__main__':
    
    main()
    if args.verbose == 1:
        print('syntax tree written in textual format at tree.txt')
    subprocess.run(['python3','graph.py','tree.txt','tree.tree'])
    if args.verbose == 1:
        print('syntax tree written in tree format at tree.tree')
    subprocess.run(['python2','makeTrees.py','tree.tree','tree.dot'])
    if args.verbose == 1:
        print('dot file written at tree.dot')
    subprocess.run(['dot','-Tps','-o',args.out,'tree.dot'])
    # subprocess.run(['xdg-open',args.out])
