using DataStructures

include("Scanner.jl")
# using Scanner

include("AST.jl")
# using AST

# Function determining if a string is entirely numeric or digit
isDigit(str::String) = all(isdigit, str)
isLetter(str::String) = all(isletter, str)
isidentifier(str::Char) = isletter(str) || isdigit(str) || str == '_'
isIdentifier(str::String) = all(identifier, str)

#Create Trie to represent all tokens
tokens = Trie{ASTType}()

# Read list of reserved tokens and construct the token trie
open("keywords.txt") do file
  while !eof(file)
    line::String = readline(file)
    tokens[line] = ASTToken
  end
end

file = open("test.txt")

while !eof(file)
  println(readLineToAST(tokens, file))
end

close(file)
