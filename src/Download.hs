{-# LANGUAGE OverloadedStrings #-}  
module Download where

import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.ByteString.Char8 as B 
import Network.HTTP.Simple
import Data.Text.ICU.Convert

userAgent = "Mozilla/5.0 (en-US) Firefox/2.0.0.6667" 



downloadHtml :: String -> IO B.ByteString
downloadHtml url = do

  request' <- parseRequest url
  let request
        = setRequestMethod "GET"
        $ setRequestSecure True
        $ setRequestPort 443
        $ setRequestHeader "User-Agent" [userAgent]
        $ request'
  getResponseBody <$> httpBS request

convertFromJis :: B.ByteString -> IO String
convertFromJis l = do
  conv <- open "Shift_JIS" Nothing
  pure $ T.unpack $ toUnicode conv l  
