factorialLet :: Int -> Int
factorialLet n =
  let go 0 acc = acc
      go k acc = go (k - 1) (k * acc)
  in go n 1

factorialWhere :: Int -> Int
factorialWhere n = go n 1
  where
    go 0 acc = acc
    go k acc = go (k - 1) (k * acc)

-- 使用例
main :: IO ()
main = do
  let num = 5
  putStrLn $ "Factorial of " ++ show num ++ " using let: " ++ show (factorialLet num)
  putStrLn $ "Factorial of " ++ show num ++ " using where: " ++ show (factorialWhere num) 
