module Main (main) where

import ParseSiml
import ConstructHtml

main :: IO ()
main = tests

tests :: IO()
tests = do
  siml ""
  siml "[]"
  siml "[html]"
  siml "[html()]"
  siml "[html ()]"
  siml "[html\"\"]"
  siml "[html()\"\"]"
  siml "[html[]]"
  file <- readFile "src/test.siml"
  siml file
  where
    siml s = do
      print s
      print $ parseSiml s
