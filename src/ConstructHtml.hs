module ConstructHtml (constructHtml) where

import ParseSiml

constructHtml :: [Element] -> String
constructHtml = concatMap fromElement

fromElement :: Element -> String
fromElement (Text s) = s
fromElement (Element name attrs children) =
    "<" ++ name ++ fromAttrs attrs ++ ">"
    ++ constructHtml children
    ++ "</" ++ name ++ ">"

fromAttrs :: [Attribute] -> String
fromAttrs = concatWithSpace . (map fromAttr)

concatWithSpace :: [String] -> String
concatWithSpace = foldl (\a b -> a ++ " " ++ b) ""

fromAttr :: Attribute -> String
fromAttr (name, Nothing) = name
fromAttr (name, Just val) = name ++ "=\"" ++ val ++ "\""
