module ParseSiml
  (parseSiml
  , Element(..)
  , Attribute
  ) where

import Text.ParserCombinators.Parsec

type Attribute = (String, (Maybe String))
data Element
  = Element
    { name :: String
    , attributes :: [Attribute]
    , body :: [Element]
    }
  | Text String
  deriving Show

parseSiml :: String -> Either ParseError [Element]
parseSiml = parse simlExprs "(unknown)"

simlExprs :: GenParser Char st [Element]
simlExprs = many (simlElement <|> (fmap Text simlString))

simlElement :: GenParser Char st Element
simlElement = do 
  spaces
  char '['
  spaces
  name <- option "" $ many (noneOf " \n\t\"([]")
  spaces
  attrs <- option [] simlAttrs
  spaces
  body <- option [] simlExprs
  spaces
  char ']'
  spaces
  return $ Element name attrs body

simlString :: GenParser Char st String
simlString = do
  char '"'
  val <- many (noneOf "\"")
  char '"'
  return val

simlAttrs :: GenParser Char st [Attribute]
simlAttrs = do
  char '('
  spaces
  val <- option [] $ many simlAttr
  spaces
  char ')'
  return val

simlAttr :: GenParser Char st Attribute
simlAttr = do
  spaces
  name <- many1 (noneOf "= )")
  val <- option Nothing $ fmap Just $ do
    char '='
    simlString
  return (name, val)
