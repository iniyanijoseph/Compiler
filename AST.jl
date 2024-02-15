# module AST

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

# end
