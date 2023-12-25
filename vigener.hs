import Data.List (elemIndex)

import Control.Applicative (Applicative (liftA2))
import Control.Monad.State
import Data.Char
import Data.Maybe (fromJust, fromMaybe)

type Alphabet = String
type Key = String

alphabet = ['A' .. 'Z']

encryptString :: Alphabet -> Key -> String -> String
encryptString = hell . map . uncurry . encryptChar

decryptString :: Alphabet -> Key -> String -> String
decryptString = hell . map . uncurry . decryptChar

hell = ((. map toUpper) .) . (. (zip' . cycle . map toUpper)) . (.) 

-- hell' = (. (zip' . cycle  . map toUpper))) . ((. map toUpper) .) . (.) . map . uncurry

encryptChar :: Alphabet -> Char -> Char -> Char
encryptChar = moveInAlphabetBy (+)

decryptChar :: Alphabet -> Char -> Char -> Char
decryptChar = moveInAlphabetBy (-)

moveInAlphabetBy op alpha o c = maybe c (alpha !!) index
 where
  offset = elemIndex o alpha
  original = elemIndex c alpha
  index = getOffset (length alpha) <$> liftA2 op original offset

getOffset len offset = ((offset `rem` len) + len) `mod` len


zip' :: [Char] -> [Char] -> [(Char, Char)]
zip' [] _ = []
zip' _ [] = []
zip' (' ' : as) bs = (' ', ' ') : zip' as bs
zip' (a : as) (b : bs) = (a, b) : zip' as bs


