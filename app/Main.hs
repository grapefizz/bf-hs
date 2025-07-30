import System.Environment (getArgs)
import System.IO (hFlush, stdout)
import Data.Char (chr, ord)
import Data.Array.IO
import Control.Monad (when)

tapeSize :: Int
tapeSize = 30000

main :: IO ()
main = do
  args <- getArgs
  code <- if null args then getContents else readFile (head args)
  tape <- newArray (0, tapeSize-1) 0 :: IO (IOUArray Int Int)
  run code 0 0 tape

run :: String -> Int -> Int -> IOUArray Int Int -> IO ()
run code pc ptr tape
  | pc >= length code = return ()
  | otherwise = case code !! pc of
      '>' -> run code (pc+1) ((ptr+1) `mod` tapeSize) tape
      '<' -> run code (pc+1) ((ptr-1) `mod` tapeSize) tape
      '+' -> do v <- readArray tape ptr; writeArray tape ptr (v+1); run code (pc+1) ptr tape
      '-' -> do v <- readArray tape ptr; writeArray tape ptr (v-1); run code (pc+1) ptr tape
      '.' -> do v <- readArray tape ptr; putChar (chr v); hFlush stdout; run code (pc+1) ptr tape
      ',' -> do c <- getChar; writeArray tape ptr (ord c); run code (pc+1) ptr tape
      '[' -> do v <- readArray tape ptr
                if v == 0 then run code (findMatch code (pc+1) 1) ptr tape
                          else run code (pc+1) ptr tape
      ']' -> do v <- readArray tape ptr
                if v /= 0 then run code (findMatchBack code (pc-1) 1) ptr tape
                          else run code (pc+1) ptr tape
      _   -> run code (pc+1) ptr tape

findMatch :: String -> Int -> Int -> Int
findMatch code pc 0 = pc
findMatch code pc n = case code !! pc of
  '[' -> findMatch code (pc+1) (n+1)
  ']' -> findMatch code (pc+1) (n-1)
  _   -> findMatch code (pc+1) n

findMatchBack :: String -> Int -> Int -> Int
findMatchBack code pc 0 = pc+1
findMatchBack code pc n = case code !! pc of
  '[' -> findMatchBack code (pc-1) (n-1)
  ']' -> findMatchBack code (pc-1) (n+1)
  _   -> findMatchBack code (pc-1) n

