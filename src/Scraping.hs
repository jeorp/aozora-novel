{-# LANGUAGE Arrows, NoMonomorphismRestriction #-}

module Scraping where
import Data.Char
import Network.HTTP.Simple
import Text.XML.HXT.Core
import Text.XML.HXT.CSS



atTagCase tag = deep (isElem >>> hasNameWith ((== tag') . upper . localPart))
  where tag' = upper tag
        upper = map toUpper

extractRanking =
  atTagCase "tr"
  >>> proc r -> do
    xs <- listA onA -< r
    returnA -< xs
  where
    onA = proc r -> do
      a <- atTagCase "a" -< r
      url <- getAttrValue "href" -< a
      title <- (getText <<< deep isText) -< a
      returnA -< (url, title)


extractNovelUrl = 
  css "[align=\"right\"] > a + a"
  >>> proc r -> do
    getAttrValue "href" -< r

extractMain = 
 css "[class=\"main_text\"]"
 >>> proc r -> do
  (getText <<< deep isText) -< r

parseHTML = readString 
  [ withValidate no,
    withParseHTML yes,
    withWarnings no
  ]

scraping body parser= runX (parseHTML body >>> parser)



getUrlsFromRanking :: String -> IO [(String, String, String)]
getUrlsFromRanking url = undefined


