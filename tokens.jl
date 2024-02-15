using DataStructures

# Define types of ASTNodes
@enum ASTType begin
  ASTExpression
  ASTToken
  ASTIdentifier
end

# Define ASTNode
struct ASTNode
  value::String
  nodeType::ASTType
  children::Array{ASTNode}
end
# Pretty printing for ASTNodes. Uncommenting will have each one show full information
Base.show(io::IO, z::ASTNode) = print(io, '(', z.value, " is a ", z.nodeType, ')')

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

open("test.txt") do file
  while !eof(file)
    line::String = readline(file)
    ASTLine::Array{ASTNode} = []
    current::String = ""
    for (index, ch) in enumerate(line)
      subtrieAtCurrent = subtrie(tokens, current*ch)

      #If no new existing keyword can be formed using the current as prefix
      if subtrieAtCurrent == nothing
        if isDigit(current) #If current is seemingly forming a digit
          if isdigit(ch) #If we can continue forming a number with ch, continue forming
            current *= ch
          else # If we cannot form a number with ch stop forming and save digit
            push!(ASTLine, ASTNode(current, ASTExpression, []))
            current = string(ch)
          end
        elseif isLetter(current) # If we are trying to form a new identifier
          if isidentifier(ch) # If the identifier is still valid, continue forming
            current *= ch
          else # If the identifier isn't valid
            if haskey(tokens, current) # If a prefix cannot be formed because it already is a keyword
              push!(ASTLine, ASTNode(current, tokens[current], []))
            else # If a prefix cannot be formed because it is a new identifier, add it to the token trie
              tokens[current] = ASTIdentifier
              push!(ASTLine, ASTNode(current, tokens[current], []))
            end
            # Start a new string
            current = string(ch)
          end
        else
          # Make sure we don't try to push whitespace
          if current != " "
            push!(ASTLine, ASTNode(current, tokens[current], []))
          end
          current = string(ch)
        end
      #If an existing keyword can be formed using the current as prefix
      else
        current *= ch
      end
      if index == sizeof(line)
        if current != " "
          if isDigit(current)
            push!(ASTLine, ASTNode(current, ASTExpression, []))
          else
            push!(ASTLine, ASTNode(current, tokens[current], []))
          end
        end
      end

    end
    println(ASTLine)
  end
end
