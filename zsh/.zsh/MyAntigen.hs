{-# LANGUAGE OverloadedStrings #-}
module MyAntigen where

import Antigen (
                AntigenConfig (..)
              , defaultConfig
              , bundle
              , antigen
              , ZshPlugin (..)
              , antigenSourcingStrategy
              , filePathsSourcingStrategy
              )

bundles =
  [ ( bundle "rimraf/k" )
  , ( bundle "rupa/z" )
    { sourcingStrategy = filePathsSourcingStrategy
      [ "z.sh" ]}
  , ( bundle "zsh-users/zsh-syntax-highlighting" )
    { sourcingStrategy = filePathsSourcingStrategy
    [ "zsh-syntax-highlighting.zsh" ] }
  , ( bundle "robbyrussell/oh-my-zsh" )
    { sourcingStrategy = filePathsSourcingStrategy [
        "plugins/colored-man-pages/colored-man-pages.plugin.zsh"
        , "plugins/mosh/mosh.plugin.zsh"
        , "plugins/extract/extract.plugin.zsh"
        , "plugins/golang/golang.plugin.zsh"
        , "plugins/tmux/tmux.plugin.zsh" ] } ]

config = defaultConfig { plugins = bundles }

main :: IO ()
main = antigen config
