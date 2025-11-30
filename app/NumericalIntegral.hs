-- 台形法による数値積分
numericalIntegral :: (Double -> Double) -> Double -> Double -> Int -> Double
numericalIntegral f a b n =
  let h = (b - a) / fromIntegral n
      xs = [a + h * fromIntegral i | i <- [0..n]]
      ys = map f xs
      area = h * (sum (init ys) + sum (tail ys)) / 2
  in area

-- 使用例: f(x) = x の積分を [0,2] で計算
main :: IO ()
main = do
  let f x = x
      a = 0
      b = 2
      n = 1000  -- 分割数（大きいほど精度が高い）
      result = numericalIntegral f a b n
  putStrLn $ "∫₀² x dx ≈ " ++ show result