
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

html3 = "novel.html"

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

test3 :: IO ()
test3 = do
  b <- doesFileExist html3
  when b $ do
    body <- readFile html3
    humi <- scraping body extractMain
    writeFile "novel.txt" $ concat humi

spec :: Spec
spec = do
  describe "test scraping with hxt" $ do
    it "test 1" $ do
      test1 `shouldReturn` ()

    it "test 2" $ do
      test2 `shouldReturn` ()
    
    it "test 3" $ do
      test3 `shouldReturn` ()