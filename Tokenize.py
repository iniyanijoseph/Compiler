import re
import copy

identifierRegex = re.compile('[a-zA-Z0-9_]+$')
numberRegex = re.compile('-?[0-9]+$')
specialCharacters = re.compile("((\*|\\|-|\+)(=?))|/|={1,2}|'|,|\]|\[$")

class Tokenizer:
    def __init__(self, iostream):
        self.iostream = iostream
        self.currentToken = self.readToken()

    def readToken(self):
        current = self.iostream.read(1)
        while(current == " "):
            current = self.iostream.read(1)

        while(True):
            if (self.isValidNumber(current + self.peek())):
                current += self.iostream.read(1)
            elif (self.isValidIdentifier(current + self.peek())):
                current += self.iostream.read(1)
            elif (self.isValidToken(current + self.peek())):
                current += self.iostream.read(1)
            else:
                return current

    def peekToken(self):
        return self.currentToken

    def getToken(self):
        oldToken = self.currentToken
        self.currentToken = self.readToken()
        return oldToken

    def peek(self):
        nextChar = self.iostream.read(1)
        self.iostream.seek(self.iostream.tell()-1)
        return nextChar

    def isValidIdentifier(self, s):
        return identifierRegex.fullmatch(s) != None

    def isValidNumber(self, s):
        return numberRegex.fullmatch(s)  != None

    def isValidToken(self, s):
        return specialCharacters.fullmatch(s)  != None

