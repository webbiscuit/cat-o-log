module Main where

import Options.Applicative
import System.IO (
  BufferMode(NoBuffering),
  hSetBuffering,
  stdout)
  
data Cat = Cat String deriving (Show)

data Command
  = Add
  | Meow
  deriving (Eq, Show)

commands :: Parser Command
commands = subparser
       ( command "add"
         (info (pure Add)
               (progDesc "Add a new cat"))
      <> command "meow"
         (info (pure Meow)
               (progDesc "Make your cats meow"))
       )

run :: Command -> IO ()
run Add = runAddCat
run Meow = putStrLn "Meow!"

runAddCat :: IO ()
runAddCat = do
  hSetBuffering stdout NoBuffering
  putStr "What's the name of your cat? "
  catName <- getLine

  putStrLn ("Adding a cat: " ++ catName)
  return ()  

opts :: ParserInfo Command
opts = info (commands <**> helper) idm

main :: IO ()
main = execParser opts >>= run
