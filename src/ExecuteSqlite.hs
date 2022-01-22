{-# LANGUAGE TemplateHaskell, DataKinds, FlexibleContexts #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeApplications  #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module ExecuteSqlite where
import Data.Extensible
import Lens.Micro
import Data.Proxy
import GHC.TypeLits
import Database.SQLite.Simple.FromRow (field, FromRow(..)) 
import Database.SQLite.Simple.FromField (FromField)

instance Forall (KeyTargetAre KnownSymbol FromField) xs => FromRow (Record xs) where
  fromRow =  hgenerateFor (Proxy @ (KeyTargetAre KnownSymbol FromField)) (const $ Field . pure <$> field)