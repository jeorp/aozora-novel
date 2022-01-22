{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE OverloadedLabels           #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TypeOperators              #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeApplications  #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Common where

import Data.Proxy
import qualified Data.Text as T
import Data.Extensible
import Data.Time.Clock (UTCTime)


type AuthorField =
 '[
    "author_id" :> T.Text,
    "author_html_path" :> T.Text
  ]

type Author = Record AuthorField

type ContentFiled = 
 '[
    "content_id" :> Int,
    "created_at" :> UTCTime,
    "title" :> T.Text,
    "content_html_url" :> T.Text,
    "author_id" :> Int,
    "shiori" :> Int
 ]

type Content = Record ContentFiled

type HistoryField =
 '[
    "content_id" :> Int,
    "created_at" :> UTCTime,
    "done" :> Bool,
    "descript" :> T.Text
 ]

type History = Record HistoryField
