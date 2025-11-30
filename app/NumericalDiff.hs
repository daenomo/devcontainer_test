-- 数値微分（前進差分法）
numericalDiff :: (Double -> Double) -> Double -> Double -> Double
numericalDiff f x h = (f (x + h) - f x) / h

-- 関数 f(x) = x + 1 の微分を x = 3 で計算
main :: IO ()
main = do
  let f x = x + 1      -- 微分すると常に 1 になる関数
      x = 3.0          -- 微分したい点
      h = 1e-6         -- 小さな差分
      diff = numericalDiff f x h
  putStrLn $ "f'(3) ≈ " ++ show diff