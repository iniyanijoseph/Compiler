using DataStructures

include("AST.jl")
include("Scanner.jl")

# Function determining if a string is entirely numeric or digit
isDigit(str::String) = all(isdigit, str)
isLetter(str::String) = all(isletter, str)
isidentifier(str::Char) = isletter(str) || isdigit(str) || str == '_'
isIdentifier(str::String) = all(identifier, str)
function isEmptyLine(line::Vector{ASTNode})::Bool
    for node::ASTNode in line
        if node.value != "\t" && node.value != " "
            return false
        end
    end
    return true
end

function stringToNodeType(id::String)::ASTType
	if id == "FOR"
		return FOR
	elseif id == "WHILE"
		return WHILE
	elseif id == "IF"
		return IF
	elseif id == "ELSE"
		return ELSE
	elseif id == "FUNCTION"
		return FUNCTION
	elseif id == "RETURN"
		return RETURN
	elseif id == "INDENT"
		return INDENT
	elseif id == "BREAK"
		return BREAK
	elseif id == "CONTINUE"
		return CONTINUE
	elseif id == "LOGICALOPERATOR"
		return LOGICALOPERATOR
		return LOGICALOPERATOR
	elseif id == "VARIABLE"
		return VARIABLE
	elseif id == "TYPE"
		return TYPE
	elseif id == "OPERATOR"
		return OPERATOR
	elseif id == "COMMENT"
		return COMMENT
	elseif id == "BOOLEANLITERAL"
		return BOOLEANLITERAL
	elseif id == "STRINGLITERAL"
		return STRINGLITERAL
	elseif id == "STRINGBREAK"
		return STRINGBREAK
	elseif id == "DEFINITION"
		return DEFINITION
	elseif id == "COMPARISON"
		return COMPARISON
	elseif id == "OPENBRACKET"
		return OPENBRACKET
	elseif id == "CLOSEBRACKET"
		return CLOSEBRACKET
	elseif id == "SEPERATOR"
		return SEPERATOR
	elseif id == "BLOCK"
		return BLOCK
	elseif id == "ARGUMENTS"
		return BLOCK
	end
end

function ParseExpression(expression::Vector{ASTNode}, i::Integer)

end

#Create Trie to represent all tokens
tokens = Trie{ASTType}()

# Read list of reserved tokens and construct the token trie
open("keywords.txt") do file
    while !eof(file)
        line::String = readline(file)
        line, id = split(line, ":")
        nodeType::ASTType = stringToNodeType(id)
        
        tokens[line] = nodeType
    end
end

bnf = Set{Integer}()
open("BNF.txt") do file
	while !eof(input)
		line::String = split(readline, " ")
		##Bitmask each line for reference in rebuilding
	end
end

open("test.txt") do input
	while !eof(input)
		line::Vector{ASTNode} = readLineToAST(tokens, input)
		if (isEmptyLine(line)) # Inore Blank Lines
			continue
		end
	end
end



close(input)
