{-# LANGUAGE OverloadedStrings #-}
module MyAntigen where

import Antigen (
                -- Rudimentary imports
                AntigenConfig (..)
              , defaultConfig
              , bundle
              , antigen
                -- If you want to source a bit trickier plugins
              , ZshPlugin (..)
              , antigenSourcingStrategy
              , filePathsSourcingStrategy
              )

bundles =
  [
  ( bundle "rupa/z" )
    { sourcingStrategy = filePathsSourcingStrategy
      [ "z.sh" ]
    },
  ( bundle "robbyrussell/oh-my-zsh" )
    { sourcingStrategy = filePathsSourcingStrategy
      [
        "plugins/colored-man-pages/colored-man-pages.plugin.zsh",
        "plugins/extract/extract.plugin.zsh",
        "plugins/golang/golang.plugin.zsh",
        "plugins/tmux/tmux.plugin.zsh"
      ]
    }
  ]

config = defaultConfig { plugins = bundles }

main :: IO ()
main = antigen config
