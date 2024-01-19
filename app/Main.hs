{-# LANGUAGE QuasiQuotes #-}
module Main where

import ParseSiml (parseSiml)
import ConstructHtml (constructHtml)
import System.FilePath
import Options.Applicative
import Options.Applicative.Help.Pretty (pretty)
import Data.String.Interpolate (i)

data Options = Options
  { outputDir :: String
  , optArgs :: [String]
  } deriving Show

parseOptions :: Parser Options
parseOptions = Options
  <$> strOption
      ( short 'o'
     <> long "output-dir"
     <> metavar "PATH"
     <> value ""
     <> help "Compile the files to this location (puts the html file next to the original file otherwise)")
  <*> some (argument str (metavar "FILEPATH..."))

footerText :: String
footerText = [i|
SIML Reference
--------------
Language Syntax:
Definiton: [element-name <optional-attribute-set> <optional-children>]
  <optional-attribute-set>: () or (key="value") or nothing
  <optional-children>: "text" or more siml
Example:
  [element-name(attribute1="value" flag-attribute) "string" [child-element]]

A more concrete example:
Siml looks like this:
  [html [head [title "An HTML page"]] [body [h1 "This is a Heading"]]]
Compiled to HTML:
  <html>
  <head><title>An HTML page</title></head>
  <body><h1>This is a Heading</h1></body>
  </html>
|]


main :: IO ()
main = do
  let opts = info (parseOptions <**> helper)
                ( fullDesc
                <> header "SImple Markup Language (SIML) Compiler"
                <> progDesc "Siml is a markup language that is intended to be compiled to HTML"
                <> footerDoc (Just $ pretty footerText))
  options <- execParser opts
  mapM_ (compileHtmlFile (outputDir options)) (optArgs options)

compileHtmlFile :: String -> String -> IO ()
compileHtmlFile outputPath filePath = do
  file <- readFile filePath
  case parseSiml file of
    Right a ->
      writeFile (genFilePath outputPath filePath) $ constructHtml a
    Left _ -> print "Parse ERROR!"

genFilePath :: String -> String -> String
genFilePath outputPath filePath =
  if isValid outputPath
  then outputPath </> (replaceExtension (takeFileName filePath) "html")
  else replaceExtension filePath "html"
