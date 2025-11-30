module Main where

-- 台形法（安定版）
integrateTrapezoid :: (Double -> Double) -> Double -> Double -> Int -> Double
integrateTrapezoid f a b n =
  let h = (b - a) / fromIntegral n
      xs = [a + h * fromIntegral i | i <- [0..n]]
      ys = map f xs
      s = sum (init ys) + sum (tail ys)
  in h * s / 2

-- 数値微分（中心差分）
diffCentral :: (Double -> Double) -> Double -> Double -> Double
diffCentral g x h = (g (x + h) - g (x - h)) / (2 * h)

-- テスト関数と原始関数
f1, f2, f3 :: Double -> Double
f1 x = x                    -- F1(x) = x^2 / 2
f2 x = x*x                  -- F2(x) = x^3 / 3
f3  = sin                 -- F3(x) = -cos x

f1', f2', f3' :: Double -> Double
f1' x = x*x / 2
f2' x = x*x*x / 3
f3' x = - cos x

checkFTC1 :: IO ()
checkFTC1 = do
  let a = 0; b = 2; n = 10000
      exact1 = f1' b - f1' a
      exact2 = f2' b - f2' a
      exact3 = f3' b - f3' a
      num1 = integrateTrapezoid f1 a b n
      num2 = integrateTrapezoid f2 a b n
      num3 = integrateTrapezoid f3 a b n
  putStrLn "=== Fundamental Theorem (Part 1): ∫ f = F(b)-F(a) ==="
  putStrLn $ "f(x)=x      : exact=" ++ show exact1 ++ ", numeric=" ++ show num1
  putStrLn $ "f(x)=x^2    : exact=" ++ show exact2 ++ ", numeric=" ++ show num2
  putStrLn $ "f(x)=sin x  : exact=" ++ show exact3 ++ ", numeric=" ++ show num3

  -- G(x) = ∫_a^x f(t) dt を台形法で定義（x が a より小さい場合も考慮）
gFromF :: (Double -> Double) -> Double -> Int -> (Double -> Double)
gFromF f a n x = if x >= a
        then integrateTrapezoid f a x n
        else - integrateTrapezoid f x a n

checkFTC2 :: IO ()
checkFTC2 = do
  let a = 0
      nInt = 4000     -- 積分の分割数
      hDiff = 1e-4    -- 微分用ステップ
      xs = [0.0, 0.5, 1.0, 1.5, 2.0]

      test f name = do
        let g = gFromF f a nInt
            approxAt x = diffCentral g x hDiff
        putStrLn $ "Function: " ++ name
        mapM_ (\x -> putStrLn $
              "  x=" ++ show x ++
              ", G'(x)≈" ++ show (approxAt x) ++
              ", f(x)=" ++ show (f x) ++
              ", error=" ++ show (approxAt x - f x)) xs

  putStrLn "=== Fundamental Theorem (Part 2): d/dx ∫_a^x f = f(x) ==="
  test f1 "f(x)=x"
  test f2 "f(x)=x^2"
  test f3 "f(x)=sin x"

aa :: Double -> Double
aa 1 = 2
aa x = x

main :: IO ()
main = do
  checkFTC1
  checkFTC2
  print $ aa 1
  print $ aa 3