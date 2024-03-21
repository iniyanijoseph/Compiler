import re
from Tokenize import Tokenizer

OPERATOR_PRECEDENCE = {
    "-": 12,
    "+": 12,
    "*": 13,
    "/": 13,
}

cannotParseAsExpression = re.compile("[^(\d|\*|\-|/|\+)]")

class Node:
    def __init__(self, token="", *args):
        self.token = token
        self.children = args

    def __str__(self):
        return self.printTree(self)

    def printTree(self, node):
        out = ""
        if node == None:
            return

        for child in node.children:
            out += self.printTree(child) + " "

        out += node.token

        return out

def BinaryExpression(tokenizer : Tokenizer, previousPrecedence):
    left = Node(tokenizer.getToken())

    if(tokenizer.peekToken() == None or cannotParseAsExpression.match(tokenizer.peekToken())):
        return left
    while(getPrecedence(tokenizer.peekToken()) > previousPrecedence):
        operator = tokenizer.getToken()
        right = BinaryExpression(tokenizer, getPrecedence(operator))

        left = Node(operator, left, right)
        if(tokenizer.peekToken() == None):
            return left

    return left

def UnaryExpression():
    pass

def getPrecedence(token):
    if(not token in OPERATOR_PRECEDENCE):
        return 0
    else:
        return OPERATOR_PRECEDENCE[token]

with open("out.ll", "w") as output:
    output.write('''ModuleID = 'examples/test1'
        source_filename = "examples/test1"
        target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
        target triple = "x86_64-pc-linux-gnu"

        @print_int_fstring = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1; Function Attrs: noinline nounwind optnone uwtable
        define dso_local i32 @main() #0 {''')

    with open("test.txt") as rawFile:
        file = Tokenizer(rawFile)
        tree = BinaryExpression(file, 0)
        print(tree)
        tree = BinaryExpression(file, 0)
        print(tree)
        tree = BinaryExpression(file, 0)
        print(tree)

    output.write("""ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 10.0.0-4ubuntu1"}""")

