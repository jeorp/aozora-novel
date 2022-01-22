{-# LANGUAGE Arrows, NoMonomorphismRestriction #-}
module Scraping where
import Data.Char
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.ByteString.Lazy.Char8 as LB
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

extractNovelUrl :: ArrowXml cat => cat XmlTree String
extractNovelUrl = 
  css "[align=\"right\"] > a + a"
  >>> proc r -> do
    getAttrValue "href" -< r


parseHTML = readString 
  [ withValidate no,
    withParseHTML yes,
    withWarnings no
  ]

scraping body parser= runX (parseHTML body >>> parser)

donwloadHtml :: String -> IO String
donwloadHtml url = do
  request <- parseRequest url
  T.unpack . T.decodeUtf8 . getResponseBody <$> httpBS request

getUrlsFromRanking :: String -> IO [(String, String, String)]
getUrlsFromRanking url = undefined
