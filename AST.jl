# Define types of ASTNodes
@enum ASTType begin
    EXPRESSION
    IDENTIFIER
    FOR
    WHILE
    IF
    ELSE
    FUNCTION
    RETURN
    INDENT
    BREAK
    CONTINUE
    LOGICALOPERATOR
    VARIABLE
    TYPE
    OPERATOR
    COMMENT
    BOOLEANLITERAL
    STRINGLITERAL
    STRINGBREAK
    DEFINITION
    COMPARISON
    OPENBRACKET
    CLOSEBRACKET
    SEPERATOR
	BLOCK
	ARGUMENTS
end

# Define ASTNode
struct ASTNode
    value::String
    nodeType::ASTType
    children::Array{ASTNode}
end
# Pretty printing for ASTNodes. Uncommenting will have each one show full information
Base.show(io::IO, z::ASTNode) = print(io, '(', z.value, " is a ", z.nodeType, ')')
