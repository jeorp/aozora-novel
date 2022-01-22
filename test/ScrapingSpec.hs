
module ScrapingSpec where 

import Test.Hspec
import System.Directory
import qualified Data.ByteString.Char8 as B 
import Control.Monad 
import Scraping
import Download
--import Text.XML.HXT.Core


main :: IO ()
main = hspec spec

html = "ranking2018.html"

html2 = "card.html"

test1 :: IO ()
test1 = do
  b <- doesFileExist html
  when b $ do
    body <- readFile html
    links <- scraping body extractRanking
    print $ links !! 1 -- note : head is empty 

test2 :: IO ()
test2 = do
  b <- doesFileExist html2
  when b $ do
    body <- readFile html2
    link <- scraping body extractNovelUrl
    print $ last link

spec :: Spec
spec = do
  describe "test scraping with hxt" $ do
    it "test 1" $ do
      test1 `shouldReturn` ()

    it "test 2" $ do
      test2 `shouldReturn` ()
    
    it "test 3" $ do
      (downloadHtml "https://www.aozora.gr.jp/cards/000119/files/624_14544.html" >>= convertFromJis >>= writeFile "novel.html") `shouldReturn` ()