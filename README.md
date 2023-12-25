# What is this

This is my small example project (Vigenère cipher) written in haskell

trying my best to conquer pointfree for maximal composition use


```hs
ghci> alphabet = ['A' .. 'Z']
ghci> key = "SUPERSECRET"
ghci> sourceText = "Hello, there! this is hella fun"

ghci> encrypted = encryptString alphabet key sourceText
ghci> decrypted = decryptString alphabet key encrypted

ghci> encrypted
"ZYAPF, VYIKW! XYAW ZW ZYAPR JWE"
ghci> decrypted
"HELLO, THERE! THIS IS HELLA FUN"
```

some of intermediate results of making function pointfree
```hs

-- I)
hell f alphabet key w = map uncurry (f alphabet) zip' (cycle key) (map toUpper w)

-- II) partial pointfree 1  FAVORITE
hell f key = map f . zipWithKey . map toUpper
 where
  zipWithKey = zip' (cycle key)

-- III) partial pointfree 2
hell f = flip (.) (map toUpper) . (.) (fmap f) . zip' . cycle

-- IV) pointfree 3
hell = flip (.) cycle . flip (.) zip' . (.) ((.) (. map toUpper) . (.)) fmap

-- V) my greatest functor kung fu
hell = fmap ((flip fmap) cycle) (fmap ((flip fmap) zip') (fmap (fmap (fmap ((flip fmap) (fmap toUpper))) fmap) fmap))

```